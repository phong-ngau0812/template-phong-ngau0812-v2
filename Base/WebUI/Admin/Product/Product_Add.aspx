<%@ Page Language="C#" MasterPageFile="~/Template/CMS.Master" AutoEventWireup="true" CodeFile="Product_Add.aspx.cs" Inherits="Backend_Admin_Product_Product_Add" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <title>Sản phẩm</title>
    <!-- DataTables -->
    <link href="/theme/plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <!-- Responsive datatable examples -->
    <link href="/theme/plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="/theme/plugins/select2/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="/theme/plugins/daterangepicker/daterangepicker.css" rel="stylesheet" />
    <link href="/theme/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.css" rel="stylesheet" type="text/css" />
    <link href="/theme/plugins/timepicker/bootstrap-material-datetimepicker.css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <form runat="server" id="frm1" class="form-parsley">
        <div class="container-fluid">
            <!-- Page-Title -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="page-title-box">
                        <div class="float-right">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item active"><a>Thêm mới sản phẩm</a></li>
                                <li class="breadcrumb-item"><a href="../Product/Product_List">Quản lý sản phẩm</a></li>
                                <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                            </ol>
                        </div>
                        <h4 class="page-title">Thêm mới sản phẩm</h4>
                    </div>
                    <!--end page-title-box-->
                </div>

                <!--end col-->
            </div>
            <!-- end page title end breadcrumb -->
            <asp:ScriptManager runat="server" ID="src"></asp:ScriptManager>

            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Tên sản phẩm<span class="red">*</span></label>
                                        <asp:TextBox runat="server" ID="txtTitle" ClientIDMode="Static" CssClass="form-control" required="true" data-parsley-required-message="Chưa nhập tên sản phẩm"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Tên chủ thể<span class="red">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddlProductBrand" CssClass="form-control select2" data-parsley-required="true" data-parsley-allselected="true" data-parsley-required-message="Chưa chọn chủ thể"></asp:DropDownList>
                                    </div>
                                     <div class="form-group">
                                        <label>Mã Sản Phẩm<span class="red"></span></label>
                                        <asp:TextBox runat="server" ID="txtProductCode" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Nhóm SP OCOP <span class="red">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddlCate" CssClass="form-control select2" data-parsley-required="true" data-parsley-allselected="true" data-parsley-required-message="Chưa chọn danh mục"></asp:DropDownList>
                                    </div>
                                    <asp:UpdatePanel runat="server" ID="up" Visible="false">
                                        <ContentTemplate>
                                            <div class="form-group">
                                                <label>Tỉnh thành<span class="red">*</span></label>
                                                <asp:DropDownList runat="server" ID="ddlLocation" CssClass="form-control select2" data-parsley-required="true" data-parsley-allselected="true" data-parsley-required-message="Chưa chọn tỉnh thành" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged"></asp:DropDownList>
                                            </div>
                                            <div class="form-group">
                                                <label>Huyện<span class="red">*</span></label>
                                                <asp:DropDownList runat="server" ID="ddlDistrict" CssClass="form-control select2" data-parsley-required="true" data-parsley-allselected="true" data-parsley-required-message="Chưa chọn huyện"></asp:DropDownList>
                                            </div>
                                        </ContentTemplate>
                                        <%-- <Triggers>
                                            <asp:PostBackTrigger ControlID="btnSave" />
                                        </Triggers>--%>
                                    </asp:UpdatePanel>
                                    <%--   <div class="form-group">
                                        <label>Chất lượng<span class="red">*</span></label>
                                        <asp:DropDownList runat="server" ID="ddlQuality" CssClass="form-control select2" data-parsley-required="true" data-parsley-allselected="true" data-parsley-required-message="Chưa chọn chất lượng"></asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <label>Giá sản phẩm<span class="red">*</span></label>
                                        <asp:TextBox runat="server" ID="txtPriceOld" ClientIDMode="Static" CssClass="form-control formatMoney" required="true" data-parsley-required-message="Chưa nhập giá sản phẩm"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Giá khuyến mãi<span class="red">*</span></label>
                                        <asp:TextBox runat="server" ID="txtPrice" ClientIDMode="Static" CssClass="form-control formatMoney" required="true" data-parsley-required-message="Chưa nhập giá khuyễn mãi sản phẩm"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Năm đánh giá</label>
                                        <asp:TextBox runat="server" type="number" ID="txtYearEvaluate" ClientIDMode="Static" CssClass="form-control" required="true" data-parsley-required-message="Chưa nhập năm đánh giá"></asp:TextBox>
                                    </div>--%>

                                    <div class="form-group">
                                        <label>Phân hạng sao </label>
                                        <asp:DropDownList runat="server" ID="ddlStar" Width="80px" CssClass="form-control ">
                                            <asp:ListItem Value="2"></asp:ListItem>
                                            <asp:ListItem Value="3"></asp:ListItem>
                                            <asp:ListItem Value="4"></asp:ListItem>
                                            <asp:ListItem Value="5"></asp:ListItem>
                                            <asp:ListItem Value="6" Text="Tiềm năng 5 sao"></asp:ListItem>
                                        </asp:DropDownList>

                                    </div>
                                    <div class="form-group">
                                        <label>Quyết định phân hạng</label>
                                        <asp:TextBox runat="server" ID="txtNo" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group" runat="server" id="HideNgaySinh">
                                        <label>Ngày cấp</label>
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="txtBirth" ClientIDMode="Static" CssClass="form-control" name="birthday" />
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="dripicons-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">

                                    <div class="form-group">
                                        <label>Thông tin sản phẩm</label>
                                        <CKEditor:CKEditorControl ID="txtDescription" BasePath="/ckeditor/" runat="server">
                                        </CKEditor:CKEditorControl>
                                    </div>

                                    <div class="form-group">
                                        <div class="row ">
                                            <div class="col-lg-6">
                                                <label>Ảnh sản phẩm (500px - 500px)</label>
                                                <br />
                                                <div style="margin: 5px 0px;">
                                                    <a href="<%=avatar %>" target="_blank">
                                                        <asp:Image ID="imganh" runat="server" ImageUrl='../../images/no-image-icon.png' Width="100px" />
                                                    </a>
                                                </div>

                                                <asp:FileUpload ID="fulAnh" runat="server" ClientIDMode="Static" onchange="img();" />
                                            </div>
                                             <div class="col-lg-6">
                                                <label>Ảnh nhãn sản phẩm (500px - 500px)</label>
                                                <br />
                                                <div style="margin: 5px 0px;">
                                                    <a href="<%=avatar %>" target="_blank">
                                                        <asp:Image ID="Image1" runat="server" ImageUrl='../../images/no-image-icon.png' Width="100px" />
                                                    </a>
                                                </div>

                                                <asp:FileUpload ID="fulAnhLable" runat="server" ClientIDMode="Static" onchange="img1();" />
                                            </div>
                                             <div class="col-lg-6" style="margin-top:10px;" >
                                                <label>Ảnh chứng chỉ sản phẩm (500px - 500px)</label>
                                                <br />
                                                <div style="margin: 5px 0px;">
                                                    <a href="<%=avatar %>" target="_blank">
                                                        <asp:Image ID="Image2" runat="server" ImageUrl='../../images/no-image-icon.png' Width="100px"  />
                                                    </a>
                                                </div>

                                                <asp:FileUpload ID="fulAnhCertificate" runat="server" ClientIDMode="Static" onchange="img2();" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>Liên hệ</label>
                                        <asp:TextBox runat="server" ID="txtContact" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                    </div>

                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <asp:Button runat="server" ID="btnSave" ClientIDMode="Static" OnClick="btnSave_Click" CssClass="btn btn-gradient-primary waves-effect waves-light" Text="Lưu" />
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


            </div>
            <!-- container -->

            <!--  Modal content for the above example -->
    </form>
    <!-- /.modal -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceBottom" runat="server">
    <!-- Buttons examples -->

    <script src=" /theme/plugins/select2/select2.min.js"></script>

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
    <%--<script src="../../theme/assets/pages/jquery.forms-advanced.js"></script>--%>

    <!--Wysiwig js-->
    <script src="/theme/plugins/tinymce/tinymce.min.js"></script>
    <script src="/theme/assets/pages/jquery.form-editor.init.js"></script>
    <!-- App js -->
    <script src="/theme/assets/js/jquery.core.js"></script>
    <script src="../../js/Function.js"></script>
    <script>
        function img() {
            var url = inputToURL(document.getElementById("<%=fulAnh.ClientID%>"));
            document.getElementById("<%=imganh.ClientID %>").src = url;
        }
        function img1() {
            var url = inputToURL(document.getElementById("<%=fulAnhLable.ClientID%>"));
             document.getElementById("<%=Image1.ClientID %>").src = url;
        }
        function img2() {
            var url = inputToURL(document.getElementById("<%=fulAnhCertificate.ClientID%>"));
            document.getElementById("<%=Image2.ClientID %>").src = url;
        }
        function inputToURL(inputElement) {
            var file = inputElement.files[0];
            return window.URL.createObjectURL(file);
        }
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
    </script>

    <script>
        $(window).on('load', function () {
            setTimeout(function () { $('#spinner').fadeOut(); }, 200);
        })
        function Init() {
            setTimeout(function () { $('#lblMessage').fadeOut(); }, 5000);
            //$(function () {
            //    $(".formatMoney").keyup(function (e) {
            //        $(this).val(format($(this).val()));
            //    });
            //});
        }

        $(document).ready(function () {
            $(".select2").select2({
                width: '100%'
            });
            Init();

        });
    </script>

</asp:Content>
