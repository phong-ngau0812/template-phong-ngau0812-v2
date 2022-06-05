<%@ Page Title="" Language="C#" MasterPageFile="~/Template/CMS.master" AutoEventWireup="true" CodeFile="User_ChangePassword.aspx.cs" Inherits="User_ChangePassword" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHead" runat="Server">
    <title>Đổi mật khẩu</title>
    <!-- DataTables -->
    <link href="/theme/plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <!-- Responsive datatable examples -->
    <link href="/theme/plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderBody" runat="Server">
    <form runat="server" id="frm1">
        <div class="container-fluid">
            <!-- Page-Title -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="page-title-box">
                        <div class="float-right">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item active"><a>Đổi mật khẩu</a></li>
                                <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                            </ol>
                        </div>
                        <h4 class="page-title">Đổi mật khẩu</h4>
                    </div>
                    <!--end page-title-box-->
                </div>

                <!--end col-->
            </div>
            <!-- end page title end breadcrumb -->
            <div class="row">
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <label>Mật khẩu cũ</label>
                            <asp:TextBox ID="CurrentPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqword" ControlToValidate="CurrentPassword" runat="server" ErrorMessage="Vui lòng nhập mật khẩu cũ"></asp:RequiredFieldValidator>
                            <br />
                            <label>Mật khẩu mới</label>
                            <asp:TextBox ID="NewPasswordRequired" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="NewPasswordRequired" runat="server" ErrorMessage="Vui lòng nhập mật khẩu mới"></asp:RequiredFieldValidator>
                            <br />
                            <label>Xác nhận mật khẩu mới</label>
                            <asp:TextBox ID="ConfirmNewPasswordRequired" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="ConfirmNewPasswordRequired" runat="server" ErrorMessage="Vui lòng xác nhận lại khẩu mới"></asp:RequiredFieldValidator>
                            <br />
                        <asp:Label runat="server" ID="lblMessage" CssClass="msg-sc-edit" ClientIDMode="Static" Visible="false"></asp:Label>
                            <br />
                            <asp:Button ID="ChangePasswordPushButton" OnClick="ChangePasswordPushButton_Click" CssClass="btn btn-gradient-primary waves-effect waves-light" runat="server" Text="Thay đổi" />
                            <asp:Button ID="CancelPushButton" CssClass="btn btn-gradient-danger waves-effect m-l-5" runat="server" CausesValidation="False" CommandName="Cancel" OnClick="CancelPushButton_Click" Text="Thoát" />
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- container -->
       
        <!--  Modal content for the above example -->

    </form>
    <!-- /.modal -->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceBottom" runat="Server">
    <!-- Buttons examples -->
    <script>
        $(window).on('load', function () {
            setTimeout(function () { $('#spinner').fadeOut(); }, 200);
        })
        function Init() {
            setTimeout(function () { $('#lblMessage').fadeOut(); }, 5000);
        }
        $(document).ready(function () {
            Init();
        });
    </script>
</asp:Content>
