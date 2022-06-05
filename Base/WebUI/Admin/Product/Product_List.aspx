<%@ Page Language="C#" MasterPageFile="~/Template/CMS.Master" AutoEventWireup="true" CodeFile="Product_List.aspx.cs" Inherits="Backend_Admin_Product_Product_List" %>

<%@ Register Src="~/UserControl/ctlDatePicker.ascx" TagPrefix="uc1" TagName="ctlDatePicker" %>
<%@ Register Assembly="ASPnetPagerV2_8" Namespace="ASPnetControls" TagPrefix="cc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHead" runat="server">
    <title>Sản phẩm</title>
    <link href="/theme/plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="/theme/plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <!-- Responsive datatable examples -->
    <link href="/theme/plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="/theme/plugins/select2/select2.min.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderBody" runat="server">
    <form runat="server" id="frm1">
        <div class="container-fluid">
            <!-- Page-Title -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="page-title-box">
                        <div class="float-right">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item active"><a>Quản lý sản phẩm</a></li>
                                <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                            </ol>
                        </div>
                        <h4 class="page-title">Quản lý sản phẩm</h4>
                    </div>
                    <!--end page-title-box-->
                </div>
                <!--end col-->
            </div>
            <!-- end page title end breadcrumb -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <uc1:ctlDatePicker ID="ctlDatePicker1" runat="server" OnDateChange="ctlDatePicker1_DateChange" />
                            <br />
                            <div class="row">
                                <div class="col-lg-3 col-xs-12 mb-2">
                                    <asp:DropDownList runat="server" ID="ddlProductBrand" CssClass="select2 form-control" OnSelectedIndexChanged="ddlBrand_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <div class="col-lg-3 col-xs-12 mb-3">
                                    <asp:DropDownList runat="server" ID="ddlCate" CssClass="select2 form-control" OnSelectedIndexChanged="ddlCate_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <%--    <div class="col-lg-2 col-xs-12 mb-2 ">
                                    <asp:DropDownList runat="server" ID="ddlLocation" CssClass="form-control select2" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged"></asp:DropDownList>
                                </div>--%>
                                <div class="col-lg-3 col-xs-12 mb-2 ">
                                    <asp:DropDownList runat="server" ID="ddlDistrict" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged"></asp:DropDownList>
                                </div>
                                <div class="col-lg-3 col-xs-12 mb-2">
                                    <asp:TextBox runat="server" ID="txtName" placeholder="Tên Sản Phẩm" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-lg-3 col-xs-12 mb-2">
                                    <asp:DropDownList runat="server" ID="ddlStar" CssClass="select2 form-control" OnSelectedIndexChanged="ddlStar_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Value="0" Text="-- Phân hạng sao --"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="3 sao"></asp:ListItem>
                                        <asp:ListItem Value="4" Text="4 sao"></asp:ListItem>
                                        <asp:ListItem Value="5" Text="5 sao"></asp:ListItem>
                                        <asp:ListItem Value="6" Text="Tiềm năng 5 sao"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-9 col-xs-12 mb-2">
                                    <p class="text-muted mb-3 right">
                                        <asp:Button CssClass="btn btn-gradient-primary mr-3" runat="server" ID="btnSearch" Text="Tìm kiếm" OnClick="btnSearch_Click" />
                                        <asp:Button CssClass="btn btn-gradient-primary mr-3" runat="server" ID="btnAdd" Text="Thêm mới" OnClick="btnAdd_Click" />
                                         <asp:Button CssClass="btn btn-gradient-primary" runat="server" ID="btnExportFile" Text="Xuất file" OnClick="btnExportFile_Click" />
                                    </p>
                                </div>
                                <div class="col-lg-12 col-xs-12 mb-2">
                                    <label>Hiển thị </label>
                                    <asp:DropDownList runat="server" ID="ddlItem" Width="80px" AutoPostBack="true" OnSelectedIndexChanged="ddlItem_SelectedIndexChanged" CssClass="custom-select custom-select-sm form-control form-control-sm">
                                        <asp:ListItem Value="10"></asp:ListItem>
                                        <asp:ListItem Value="20"></asp:ListItem>
                                        <asp:ListItem Value="50"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <asp:UpdatePanel runat="server" ID="up">
                                <ContentTemplate>
                                    <asp:Label runat="server" ID="lblMessage" ClientIDMode="Static" Visible="false" CssClass="msg-sc-edit"></asp:Label>
                                    <table class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                        <thead>
                                            <tr>
                                                <th>Ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Danh mục sản phẩm</th>
                                                <%--  <th>Tỉnh thành</th>--%>
                                                <th>Huyện</th>
                                                <%--  <th>Giá sản phẩm</th>--%>
                                                <th>Trang chủ | Hiển thị</th>
                                                <th width="8%">Chức năng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater runat="server" ID="grdProduct" OnItemCommand="rptBNN_Product_ItemCommand" OnItemDataBound="rptBNN_Product_ItemDataBound">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <img src='<%# Common.GetImgNoURL(Eval("Image"))%>' width="100" />
                                                        </td>
                                                        <td><a href='Product_Edit?Product_ID=<%#Eval("Product_ID") %>' class="breadcrumb-item active font-15"><%#Eval("ProductName")%></a>
                                                            <br />
                                                            <p style="color: #000; font-size:90%;">
                                                                Đăng bởi: <b><%#Eval("NguoiTao")%></b> vào lúc <%# string.IsNullOrEmpty(Eval("CreateDate").ToString())?"": DateTime.Parse( Eval("CreateDate").ToString()).ToString("dd/MM/yyyy hh:mm:ss") %>
                                                                <br />
                                                                Cập nhật lần cuối bởi <b><%#Eval("NguoiSua").ToString()=="Không xác định"?Eval("NguoiTao"): Eval("NguoiSua")%></b> vào lúc <%# string.IsNullOrEmpty(Eval("ModifyDate").ToString())? DateTime.Parse( Eval("CreateDate").ToString()).ToString("dd/MM/yyyy hh:mm:ss"): DateTime.Parse( Eval("ModifyDate").ToString()).ToString("dd/MM/yyyy hh:mm:ss") %>
                                                            </p>
                                                        </td>
                                                        <td><%#Eval("CateName")%></td>
                                                        <%--       <td><%#Eval("Location")%></td>--%>
                                                        <td><%#Eval("DistrictName")%></td>
                                                        <td align="center">
                                                            <%-- <td><%#Decimal.Parse(Eval("Price").ToString()).ToString("N0")%> VNĐ</td>--%>
                                                            <asp:LinkButton runat="server" ID="btnDeactiveHome" CommandName="DeactiveHome" CssClass="mr-2" ToolTip="Kích hoạt" CommandArgument='<%#Eval("Product_ID") %>'><i class="fas fa-check text-success font-16 ml-2"></i></asp:LinkButton>
                                                            <asp:LinkButton runat="server" ID="btnActiveHome" CommandName="ActiveHome" CssClass="mr-2" ToolTip="Ngừng kích hoạt" CommandArgument='<%#Eval("Product_ID") %>'><i class="fas fa-stop text-danger font-16 ml-2"></i></asp:LinkButton>
                                                            |
                                                            <asp:LinkButton runat="server" ID="btnActive" CommandName="Deactive" CssClass="mr-2" ToolTip="Kích hoạt" CommandArgument='<%#Eval("Product_ID") %>'><i class="fas fa-check text-success font-16 ml-2"></i></asp:LinkButton>
                                                            <asp:LinkButton runat="server" ID="btnDeactive" CommandName="Active" CssClass="mr-2" ToolTip="Ngừng kích hoạt" CommandArgument='<%#Eval("Product_ID") %>'><i class="fas fa-stop text-danger font-16 ml-2"></i></asp:LinkButton>
                                                            <asp:Literal runat="server" ID="lblText" Visible="false"></asp:Literal>
                                                            <asp:Literal runat="server" ID="lblApproved" Text='<%#Eval("Status") %>' Visible="false"></asp:Literal>
                                                            <asp:Literal runat="server" ID="lblHome" Text='<%#Eval("IsHome") %>' Visible="false"></asp:Literal>
                                                        </td>
                                                        <td align="center">
                                                            <a href='Product_Edit?Product_ID=<%#Eval("Product_ID") %>' class="mr-2" title="Sửa thông tin"><i class="fas fa-edit text-success font-16"></i></a>
                                                            <asp:LinkButton runat="server" ID="btnDelete" CommandName="Delete" CssClass="mr-2" ToolTip="Xóa" CommandArgument='<%#Eval("Product_ID")%>' OnClientClick="return confirm('Bạn có chắc chắn muốn xóa không?')"><i class="fas fa-trash-alt text-danger font-16"></i></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                    <div id="x_box_pager" style="float: right; text-align: right; margin-top: 10px" runat="Server" class="box_pager">
                                        <label>Trang <%=Pager1.CurrentIndex %>/<%=TotalPage %></label>
                                        (<label> <%=TotalItem %> Sản phẩm)</label>
                                        <cc1:PagerV2_8 ID="Pager1" runat="server" OnCommand="Pager1_Command"
                                            GenerateFirstLastSection="True" GenerateGoToSection="False" GenerateHiddenHyperlinks="False"
                                            GeneratePagerInfoSection="False" NextToPageClause="" OfClause="/" PageClause=""
                                            ToClause="" CompactModePageCount="1" MaxSmartShortCutCount="5" NormalModePageCount="5"
                                            GenerateToolTips="False" BackToFirstClause="" BackToPageClause="" FromClause=""
                                            GenerateSmartShortCuts="False" GoClause="" GoToLastClause="" />
                                        <div class="clear">
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!--end card-body-->
                    </div>
                </div>
            </div>
        </div>
        <!-- container -->
        <!--  Modal content for the above example -->
    </form>
    <!-- /.modal -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceBottom" runat="server">

    <!-- Required datatable js -->
    <script src="/theme/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="/theme/plugins/datatables/dataTables.bootstrap4.min.js"></script>
    <!-- Buttons examples -->
    <script src="/theme/plugins/datatables/dataTables.buttons.min.js"></script>
    <script src="/theme/plugins/datatables/buttons.bootstrap4.min.js"></script>
    <script src="/theme/plugins/datatables/jszip.min.js"></script>
    <script src="/theme/plugins/datatables/pdfmake.min.js"></script>
    <script src="/theme/plugins/datatables/vfs_fonts.js"></script>
    <script src="/theme/plugins/datatables/buttons.html5.min.js"></script>
    <script src="/theme/plugins/datatables/buttons.print.min.js"></script>
    <script src="/theme/plugins/datatables/buttons.colVis.min.js"></script>
    <!-- Responsive examples -->
    <script src="/theme/plugins/datatables/dataTables.responsive.min.js"></script>
    <script src="/theme/plugins/datatables/responsive.bootstrap4.min.js"></script>
    <script src="/theme/assets/pages/jquery.datatable.init.js"></script>
    <script src="/theme/plugins/select2/select2.min.js"></script>
    <script>
        $(window).on('load', function () {
            setTimeout(function () { $('#spinner').fadeOut(); }, 200);
        })
        $(document).ready(function () {
            $(".select2").select2({
                width: '100%',
                language: "vi"
            });
            setTimeout(function () { $('#lblMessage').fadeOut(); }, 3000);
            if (typeof (Sys) !== 'undefined') {
                var parameter = Sys.WebForms.PageRequestManager.getInstance();
                parameter.add_endRequest(function () {
                    setTimeout(function () { $('#lblMessage').fadeOut(); }, 2000);
                });
            }
        });

    </script>
</asp:Content>
