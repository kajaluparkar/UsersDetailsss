using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Web.Configuration;
using System.Net.NetworkInformation;
using System.Security.Cryptography;


namespace UsersDetailsss
{
    public partial class UserDetails : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
        SqlConnection connection=null;
        SqlCommand command = null;
        int uid;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }

        }
        private void BindGridView()
        {

            string query = "SELECT * From users";

            using (SqlDataAdapter da = new SqlDataAdapter(query, connectionString))
            {
                DataTable dt = new DataTable();

                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
    

protected void Txtuser1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            string userName = Txtuser.Text;
            string email = Txtemail.Text;
            string mobile = Txtmobile.Text;
            string dob = Txtdob.Text;
            string country = DropDownList1.SelectedItem.ToString();
            string state = DropDownList2.SelectedItem.ToString();
            string imagePath = "";

            if (FileUpload1.HasFile)
            {
                string folderPath = Server.MapPath("~/Images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                imagePath = "~/Images/" + FileUpload1.FileName;
                FileUpload1.SaveAs(folderPath + Path.GetFileName(FileUpload1.FileName));
            }

            using (connection = new SqlConnection(connectionString))
            {
                connection.Open();
                 
                string query ="Insert into users(username,email,mobile,DOB,image,country,state) values(@username,@email,@mobile,@DOB,@image,@country,@state)";
                 command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", userName);
                command.Parameters.AddWithValue("@email", email);
                command.Parameters.AddWithValue("@mobile", mobile);
                command.Parameters.AddWithValue("@DOB", dob);
                command.Parameters.AddWithValue("@country", country);
                command.Parameters.AddWithValue("@state", state);
                command.Parameters.AddWithValue("@image", imagePath);

                try
                {
                    command.ExecuteNonQuery();
                    Response.Write("<script>alert('User details saved successfully');</script>");

                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }


            }
            BindGridView();



        }

        protected void Txtuser_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Txtdob_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            uid = Convert.ToInt32(TxtSearch.Text);
            string userName = Txtuser.Text;
            string email = Txtemail.Text;
            string mobile = Txtmobile.Text;
            string dob = Txtdob.Text;
            string country = DropDownList1.SelectedItem.ToString();
            string state = DropDownList2.SelectedItem.ToString();
            string fn= null;
            if (FileUpload1.HasFile)
            {
                fn = FileUpload1.FileName;
                FileUpload1.SaveAs(Server.MapPath(fn));
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "UPDATE users SET username = @username, email = @email, mobile = @mobile, DOB = @DOB, image = @image, country = @country, state = @state WHERE userid = @id";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", userName);
                command.Parameters.AddWithValue("@email", email);
                command.Parameters.AddWithValue("@mobile", mobile);
                command.Parameters.AddWithValue("@DOB", dob);
                command.Parameters.AddWithValue("@country", country);
                command.Parameters.AddWithValue("@state", state);
                command.Parameters.AddWithValue("@image", fn);
                command.Parameters.AddWithValue("@id", uid); 

                try
                {
                    command.ExecuteNonQuery();
                    Response.Write("<script>alert('User details updated successfully');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
            BindGridView();
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
           uid = Convert.ToInt32(TxtSearch.Text);
            using ( connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = $"SELECT * FROM users WHERE userid = @Id";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@Id", uid);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    Txtuser.Text = reader["username"].ToString();
                    Txtemail.Text = reader["email"].ToString();
                    Txtmobile.Text = reader["mobile"].ToString();
                    Txtdob.Text = reader["DOB"].ToString();
                    DropDownList1.SelectedItem.Text= reader["country"].ToString();
                    DropDownList2.SelectedItem.Text = reader["state"].ToString();

                    if (FileUpload1.HasFile)
                    {
                        string folderPath = Server.MapPath("~/Images/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        string imagePath = "~/Images/" + FileUpload1.FileName;
                        FileUpload1.SaveAs(folderPath + Path.GetFileName(FileUpload1.FileName));

                        ImgUser.ImageUrl = imagePath;
                        ImgUser.Visible = true;
                    }
                    else
                    {
                        // Use the image path from the database if FileUpload has no file
                        string imagePath = reader["image"].ToString();
                        if (!string.IsNullOrEmpty(imagePath))
                        {
                            ImgUser.ImageUrl = imagePath;
                            ImgUser.Visible = true;
                        }
                        else
                        {
                            ImgUser.Visible = false; // Hide image control if no image found
                        }
                    }
                }
                else
                {
                    Response.Write("<script>alert('User id is not found');</script>");
                }

                reader.Close();
            }
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            uid = Convert.ToInt32(TxtSearch.Text);

            using (connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "DELETE FROM users WHERE userid = @Id";
                 command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Id", uid);

                try
                {
                     command.ExecuteNonQuery();
                   
                        Response.Write("<script>alert('Data Deleted Succesfully ');</script>");
                    
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
            BindGridView();
        }

        protected void Btnclear_Click(object sender, EventArgs e)
        {
            TxtSearch.Text = string.Empty;
            Txtuser.Text = string.Empty;
            Txtemail.Text = string.Empty;
            Txtmobile.Text = string.Empty;
            Txtdob.Text = string.Empty;
            DropDownList1.SelectedIndex = 0;
            DropDownList2.SelectedIndex = 0;
            ImgUser.Visible = false;
            ImgUser.ImageUrl = string.Empty;
            FileUpload1.Dispose(); 
        }
    }

        }
    
    
