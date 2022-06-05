<%@ Page Title="" Language="C#" MasterPageFile="~/Template/CMS.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHead" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderBody" runat="Server">
    <style>
        h4 {
            text-transform: uppercase !important
        }

        .apexcharts-menu-item.exportCSV {
            display: none;
        }

        .table-bordered thead th, .table-bordered thead td {
            border-bottom-width: 2px;
            COLOR: #6d81f5;
        }

        .font-20 {
            margin-right: 5px;
        }

        span.apexcharts-tooltip-text-label span {
            display: none;
        }
    </style>
    <form runat="server" id="frm">
        <div class="container-fluid">
            <!-- Page-Title -->
            <div class="row">
                <div class="col-sm-12">
                    <h4 class="page-title text-center mb-5 mt-5 ">Chào mừng bạn đã đến với hệ thống quản trị nội dung Nông Thôn Mới Hà Nội !
                    </h4>
                    <div class="row" runat="server" id="Admin">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="header-title mt-0">Thống kê số lượng bài viết theo năm</h4>
                                    <div class="">
                                        <div id="ana_dash_ProductBrandReport" class="apex-charts"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--end card-body-->
                    </div>

                </div>
            </div>
            <asp:HiddenField runat="server" ID="NowYear" Value="" ClientIDMode="Static" />
            <asp:HiddenField runat="server" ID="LastYear" Value="" ClientIDMode="Static" />
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceBottom" runat="Server">
    <script src="/theme/plugins/apexcharts/apexcharts.min.js"></script>
    <!--<script src="../plugins/jvectormap/jquery-jvectormap-2.0.2.min.js"></script>
        <script src="../plugins/jvectormap/jquery-jvectormap-us-aea-en.js"></script>-->
    <script>
        var listNow = [];
        var listLast = [];
        var TotalNow = 0;
        var TotalLast = 0;
        $(document).ready(function () {
            //Biểu đồ tốc độ tăng trưởng của doanh nghiệp theo năm
            var ListDataNow = $("#NowYear").val();
            var splitDataNow = ListDataNow.split(',');
            $.each(splitDataNow, function (i, obj) {
                listNow.push(parseInt(splitDataNow[i]));
                TotalNow += parseInt(splitDataNow[i]);
            })
            var ListDataLast = $("#LastYear").val();
            var splitDataLast = ListDataLast.split(',');
            $.each(splitDataLast, function (i, obj) {
                listLast.push(parseInt(splitDataLast[i]));
                TotalLast += parseInt(splitDataLast[i]);
            })
            GetChartProductBrand();
            //Kết thúc biểu đồ tốc độ tăng trưởng của doanh nghiệp theo năm
        });

    </script>
    <script src="/theme/assets/pages/jquery.analytics_dashboard.init.js?v=<%=Systemconstants.Version(5) %>"></script>
    <script>
        $(window).on('load', function () {
            setTimeout(function () { $('#spinner').fadeOut(); }, 200);
        })
    </script>
</asp:Content>

