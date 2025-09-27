<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QLEmail.aspx.cs" Inherits="QLCVan.QLEmail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            window.scrollTo(0, window.outerHeight / 2);

            // thu de
            $('.clcss').mousedown(function () {
                $('.clcss').removeClass("Boiden");
                $('.clcss1').removeClass("Boiden");
                $(this).addClass("Boiden");s
                var preparent = $(this).parent().next().children().addClass("Boiden");
            });

            //            $('.clcss').mouseleave(function () {
            //                $(this).removeClass("Boiden");
            //                var preparent = $(this).parent().next().children().removeClass("Boiden");
            //            });
        });

    </script>
    <style type="text/css">
        .Boiden
        {
            background-color: Blue;
        }
        #DSDV
        {
            float: left;
        }
        #Trong
        {
            float: left;
        }
        #Gd2
        {
            float: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="QLM" style=" width:600px; height: 400px;">
        <table>
            <tr>
                <td>
                    <h3>
                        <b>DANH SÁCH CÁC ĐƠN VỊ</b></h3>
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="210px" AutoPostBack="True"
                        OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <asp:ListBox ID="ltbdanhsachnhom" runat="server" SelectionMode="Multiple" Width="270px"
                        Height="122px" DataTextField="Email" DataValueField="UserName"></asp:ListBox>
                </td>
                <td>
                    <asp:Button ID="btnchuyenleft" runat="server" Text="&gt;&gt;" OnClick="btnchuyenleft_Click" /><br />
                    <asp:Button ID="btnQuay" runat="server" Text="<<" OnClick="btnQuay_Click" />
                </td>
                <td style="text-align: right">
                    <asp:ListBox ID="ltbdanhsachnguoinhan" runat="server" SelectionMode="Multiple" Width="300px"
                        Height="122px"></asp:ListBox>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                    <asp:Button ID="btXoa" runat="server" Text="Xóa" Width="53px" 
                        onclick="btXoa_Click" />
                    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Button1" runat="server" Text="Đồng ý" OnClick="Button1_Click" />
                    <input id="Button2" type="button" value="Hủy bỏ" onclick="window.close()" />

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
