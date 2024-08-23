<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserDetails.aspx.cs" Inherits="UsersDetailsss.UserDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Details</title>
    <style type="text/css">
      
       
         h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td {
            padding: 10px;
            border: 1px solid #ddd;
            vertical-align: middle;
        }
        td label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        select,
        input[type="file"] {
            width: calc(100% - 20px);
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .spacer {
            height: 20px;
        }
        .auto-style1 {
            height: 137px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>User Details</h1>
            <p>
                <asp:TextBox ID="TxtSearch" runat="server" Width="267px"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" BorderColor="Blue" Font-Bold="True" ForeColor="Black" Height="30px" OnClick="Button1_Click" Text="Search" Width="69px" ValidationGroup="SearchGroup" />


            </p>
            <table>
                <tr>
                    <td>
                        <label for="Txtuser">UserName:</label>
                        <asp:TextBox ID="Txtuser" runat="server" Height="32px" OnTextChanged="Txtuser_TextChanged"></asp:TextBox>


                    &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Txtuser" Display="Dynamic" ErrorMessage="* UserName is required" ForeColor="Red" ValidationGroup="UserDetailsGroup"></asp:RequiredFieldValidator>


                    </td>
                    <td>
                        <label for="Txtemail">Email:</label>
                        <asp:TextBox ID="Txtemail" runat="server" Height="32px"></asp:TextBox>


                    &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Txtemail" Display="Dynamic" ErrorMessage="* Email is Required" ForeColor="Red" ValidationGroup="UserDetailsGroup"></asp:RequiredFieldValidator>


                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="Txtmobile">Mobile:</label>
                        <asp:TextBox ID="Txtmobile" runat="server" Height="32px" OnTextChanged="Txtuser1_TextChanged"></asp:TextBox>

                       
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Txtmobile" Display="Dynamic" ErrorMessage="* Mobile Number is Required" ForeColor="Red" ValidationGroup="UserDetailsGroup"></asp:RequiredFieldValidator>

                       
                    </td>
                    <td>
                        <label for="Txtdob">DoB:</label>
                        <asp:TextBox ID="Txtdob" runat="server" Height="32px" OnTextChanged="Txtdob_TextChanged"></asp:TextBox>

                    &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Txtdob" Display="Dynamic" ErrorMessage="* DOB is Required" ValidationGroup="UserDetailsGroup"></asp:RequiredFieldValidator>

                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <label for="FileUpload1">Image:</label>
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                    &nbsp;&nbsp;
                        <asp:Image ID="ImgUser" runat="server" Visible="false" Height="50px" Width="50px" />
                    </td>
                    <td class="auto-style1">
                        <label for="DropDownList1">Country:</label>
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="countryname" DataValueField="countryid">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=.;Initial Catalog=userDetails;Integrated Security=True;" ProviderName="<%$ ConnectionStrings:userDetailsConnectionString6.ProviderName %>" SelectCommand="SELECT * FROM [countries]"></asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="DropDownList1" Display="Dynamic" ErrorMessage="* Country is Required" ForeColor="Red" ValidationGroup="UserDetailsGroup"></asp:RequiredFieldValidator>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="DropDownList2">State:</label>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="statename" DataValueField="countryID">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.;Initial Catalog=userDetails;Integrated Security=True;" ProviderName="<%$ ConnectionStrings:userDetailsConnectionString7.ProviderName %>" SelectCommand="SELECT * FROM [state] WHERE ([countryID] = @countryID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList1" DefaultValue="1" Name="countryID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="DropDownList2" Display="Dynamic" ErrorMessage="* State is Required" ForeColor="Red" ValidationGroup="UserDetailsGroup"></asp:RequiredFieldValidator>
                        <br />
                    </td>
                    <td>
                        <div class="spacer"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="BtnSave" runat="server" Font-Bold="True" Height="28px" OnClick="BtnSave_Click" Text="Save" CssClass="btn" ValidationGroup="UserDetailsGroup" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnupdate" runat="server" BackColor="#FFCC00" ForeColor="Black" Text="Update" Font-Bold="True" Height="28px"  CssClass="btn" OnClick="btnupdate_Click" ValidationGroup="UserDetailsGroup"/>
                    &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btndelete" runat="server" BackColor="Red"  Text="Delete" ForeColor="Black"  Font-Bold="True" Height="28px"  CssClass="btn" OnClick="btndelete_Click" ValidationGroup="UserDetailsGroup" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="Btnclear" runat="server" BackColor="Gray" Font-Bold="True" Text="Clear" Height="28px"  CssClass="btn" ForeColor="Black" OnClick="Btnclear_Click" ValidationGroup="UserDetailsGroup" />
                    </td>
                </tr>
            </table>
        </div>
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
    </form>
</body>
</html>