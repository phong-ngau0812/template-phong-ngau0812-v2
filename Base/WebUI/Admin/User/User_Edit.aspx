<%@ Page Title="" Language="C#" MasterPageFile="~/Template/CMS.master" AutoEventWireup="true" CodeFile="User_Edit.aspx.cs" Inherits="User_Edit" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="Server">
    <link href="/theme/plugins/daterangepicker/daterangepicker.css" rel="stylesheet" />
    <link href="/theme/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.css" rel="stylesheet" type="text/css" />
    <link href="/theme/plugins/timepicker/bootstrap-material-datetimepicker.css" rel="stylesheet">
    <link href="/theme/plugins/select2/select2.min.css" rel="stylesheet" type="text/css" />
    <%--<link href="/theme/plugins/bootstrap-touchspin/css/jquery.bootstrap-touchspin.min.css" rel="stylesheet" />--%>
    <link href="/css/telerik.css?v=<%=Systemconstants.Version(5) %>" rel="stylesheet" type="text/css" />
    <style>
        .font-13 label {
            color: #656d9a;
            font-size: 14px;
            font-weight: bold;
        }

        .font-11 input {
            margin-left: 25px;
        }

        .role {
            overflow-y: scroll;
            overflow-x: hidden;
            max-height: 600px;
            padding-left: 10px;
            border: 1px solid #edf0f5;
            border-radius: 2px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" runat="Server">
    <form runat="server" id="frm1" class="form-parsley">
        <telerik:RadScriptManager runat="server" ID="sc"></telerik:RadScriptManager>
        <div class="container-fluid">
            <!-- Page-Title -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="page-title-box">
                        <div class="float-right">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item active"><%=title %></li>
                                <li class="breadcrumb-item" runat="server" id="pn"><a href="User_List">Quản lý tài khoản</a></li>
                                <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                            </ol>
                        </div>
                        <h4 class="page-title"><%=title %></h4>
                        <asp:Label runat="server" ID="lblMessage1" CssClass="msg-sc-edit" ClientIDMode="Static" Visible="false"></asp:Label>
                    </div>
                    <!--end page-title-box-->
                </div>
                <!--end col-->
            </div>
            <!-- end page title end breadcrumb -->
            <%-- <asp:ScriptManager runat="server" ID="src"></asp:ScriptManager>
            <asp:UpdatePanel runat="server" ID="up">
                <ContentTemplate>--%>
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                         <div class="card-body">

                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Tên tài khoản <span class="red">*</span></label>
                                        <asp:TextBox runat="server" ID="txtUser" Enabled="false" ClientIDMode="Static" CssClass="form-control" required data-parsley-required-message="Chưa nhập tên tài khoản"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Avatar (100 x 100px)</label>
                                        <br />
                                        <div style="margin: 5px 0px;">
                                            <a href="<%=avatar %>" target="_blank">
                                                <asp:Image ID="imganh" runat="server" ImageUrl='../../images/no-image-icon.png' Width="100px" />
                                            </a>
                                        </div>

                                        <asp:FileUpload ID="fulAnh" runat="server" ClientIDMode="Static" onchange="img();" />

                                    </div>
                                    <div class="form-group" runat="server" id="HideHoTen">
                                        <label>Họ tên <span class="red">*</span></label>
                                        <asp:TextBox runat="server" ID="txtFullName" ClientIDMode="Static" CssClass="form-control" required data-parsley-required-message="Chưa nhập họ tên"></asp:TextBox>
                                    </div>
                                     <div class="form-group">
                                        <label>E-Mail <span class="red">*</span></label>
                                        <div>
                                            <asp:TextBox runat="server" ID="txtEmail" ClientIDMode="Static" TextMode="Email" parsley-type="email" CssClass="form-control" required data-parsley-required-message="Chưa nhập Email"></asp:TextBox>
                                        </div>
                                    </div>
                                    <!--end form-group-->
                                  <%--  <div class="form-group">
                                        <label>Mật khẩu<span class="red">*</span></label>
                                        <asp:TextBox runat="server" ID="txtPass" TextMode="Password" ClientIDMode="Static" CssClass="form-control" required data-parsley-required-message="Chưa nhập mật khẩu"></asp:TextBox>
                                        <div class="mt-2">
                                            <asp:TextBox runat="server" ID="txtPassRe" CssClass="form-control" required data-parsley-required-message="Chưa nhâp xác nhận mật khẩu"
                                                data-parsley-equalto="#txtPass"
                                                placeholder="Xác nhận mật khẩu" ClientIDMode="Static" TextMode="Password"></asp:TextBox>

                                        </div>
                                    </div>--%>
                                </div>
                                <div class="col-lg-6">
                                   
                                    <div class="form-group">
                                        <label>Địa chỉ</label>
                                        <asp:TextBox runat="server" ID="txtAddress" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Số điện thoại</label>
                                        <asp:TextBox runat="server" ID="txtPhone" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <!--end form-group-->

                                    <div class="form-group" runat="server" id="HideGioiTinh">
                                        <label>Giới tính</label>
                                        <asp:DropDownList runat="server" ID="ddlGioiTinh" CssClass="form-control">
                                               <asp:ListItem Text="-Chọn giới tính-" Value="-1"></asp:ListItem>
                                            <asp:ListItem Value="0" Text="Nữ"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Nam"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>

                                    <div class="form-group" runat="server" id="HideNgaySinh">
                                        <label>Ngày sinh</label>
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="txtBirth" Text="01/01/1980" ClientIDMode="Static" CssClass="form-control" name="birthday" />
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="dripicons-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <!--end form-group-->
                                <%--    <div class="form-group">
                                        <div class="checkbox checkbox-success">
                                            <asp:CheckBox runat="server" ID="ckActive" ClientIDMode="Static" Checked="true" Text="KÍCH HOẠT" />

                                        </div>
                                    </div>--%>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <asp:Button runat="server" ID="btnSave"  ClientIDMode="Static" OnClick="btnSave_Click" CssClass="btn btn-gradient-primary waves-effect waves-light" Text="Lưu" />
                                        <asp:Button ID="btnBack" OnClick="btnBack_Click" UseSubmitBehavior="false" runat="server" ClientIDMode="Static" Text="Quay lại" CssClass="btn btn-gradient-danger waves-effect m-l-5"></asp:Button>
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" ID="lblMessage" CssClass="msg-sc-edit" ClientIDMode="Static" Visible="false"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <!--end form-group-->

                            <!--end form-->
                        </div>
                        <!--end card-body-->
                    </div>
                </div>
                <!--end card-->
            </div>
            <!-- end col -->
            <!-- end col -->
        </div>
        <%--  </ContentTemplate>
            </asp:UpdatePanel>--%>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceBottom" runat="Server">
    <script>
      
        $(window).on('load', function () {
            setTimeout(function () { $('#spinner').fadeOut(); }, 100);
        })
        function Init() {
            $("#ckActive").addClass("custom-control-input");
            setTimeout(function () { $('#lblMessage').fadeOut(); }, 3000);

        }
        $(document).ready(function () {
            Init();
            $('#txtBirth').daterangepicker({
                singleDatePicker: true,
                showDropdowns: true,
                //minYear: 1901,
                //maxYear: parseInt(moment().format('YYYY'), 10),
                locale: {
                    format: 'DD/MM/YYYY',
                },
            }, function (start, end, label) {
                //console.log("A new date selection was made: " + start.format('DD/MM/YYYY') + ' to ' + end.format('YYYY-MM-DD'));
            });
        });

    </script>
    <script>
        function img() {
            var url = inputToURL(document.getElementById("<%=fulAnh.ClientID %>"));
            document.getElementById("<%=imganh.ClientID %>").src = url;
        }
        function inputToURL(inputElement) {
            var file = inputElement.files[0];
            return window.URL.createObjectURL(file);
        }
    </script>
    <!-- Parsley js -->
    <script src="/theme/plugins/parsleyjs/parsley.min.js"></script>
    <script src="/theme/assets/pages/jquery.validation.init.js"></script>

    <!----date---->
    <script src="/theme/plugins/select2/select2.min.js"></script>
    <script src="/theme/plugins/moment/moment.js"></script>
    <script src="/theme/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js"></script>
    <script src="/theme/plugins/daterangepicker/daterangepicker.js"></script>
    <script src="/theme/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
    <script src="/theme/plugins/timepicker/bootstrap-material-datetimepicker.js"></script>
    <script src="/theme/plugins/bootstrap-touchspin/js/jquery.bootstrap-touchspin.min.js"></script>
    <%--<script src="/theme/assets/pages/jquery.forms-advanced.js"></script>--%>

    <!--Wysiwig js-->
    <script src="/theme/plugins/tinymce/tinymce.min.js"></script>
    <script src="/theme/assets/pages/jquery.form-editor.init.js"></script>
    <!-- App js -->
    <script src="/theme/assets/js/jquery.core.js"></script>

</asp:Content>

