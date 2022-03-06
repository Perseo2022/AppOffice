<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AppV_SolicitudNew.aspx.vb" Inherits="AppV_SolicitudNew" %>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="">
 <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>App Vuelos</title>
    <meta name="description" content="Aplicacion de Vuelos">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="https://i.imgur.com/QRAUqs9.png">
    <link rel="shortcut icon" href="https://i.imgur.com/QRAUqs9.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/normalize.css@8.0.0/normalize.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pixeden-stroke-7-icon@1.2.3/pe-icon-7-stroke/dist/pe-icon-7-stroke.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.2.0/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
    <link href="https://cdn.jsdelivr.net/npm/chartist@0.11.0/dist/chartist.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/jqvmap@1.5.1/dist/jqvmap.min.css" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/weathericons@2.1.0/css/weather-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.css" rel="stylesheet" />

    <script type="text/javascript">
        function myFuncionAlerta() {
            alert("Alerta JavaScript")
        }
    </script>
    <style>
        #weatherWidget .currentDesc {
            color: #ffffff !important;
        }

        .traffic-chart {
            min-height: 335px;
        }

        #flotPie1 {
            height: 150px;
        }

            #flotPie1 td {
                padding: 3px;
            }

            #flotPie1 table {
                top: 20px !important;
                right: -10px !important;
            }

        .chart-container {
            display: table;
            min-width: 270px;
            text-align: left;
            padding-top: 10px;
            padding-bottom: 10px;
        }

        #flotLine5 {
            height: 105px;
        }

        #flotBarChart {
            height: 150px;
        }

        #cellPaiChart {
            height: 160px;
        }
    </style>
        <script language="javascript" type="text/javascript">
            function show() {
                console.log('Hola Mensage');
            }

            function myFuncionAlerta() {
                alert("Alerta JavaScript");
            }
        </script>
</head>

<body oncontextmenu="return false">
    <!-- Left Panel -->
    <aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default">
            <div id="main-menu" class="main-menu collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="index.aspx"><i class="menu-icon fa fa-laptop"></i>Tablero </a>
                    </li>
                    <li class="menu-title">Vuelos</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon fa fa-cogs"></i>Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod1 = 1 And Vg_Fac1 < 3 Then %>
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1"  NavigateUrl  ="AppV_SolicitudNew.aspx" runat="server">Nueva</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                            <li><i class="pe-7s-cash"></i><asp:HyperLink ID="HyperLink2" NavigateUrl ="AppV_SolicitudxCotizar.aspx" runat="server">Por Cotizar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                            <li><i class="ti-pencil-alt"></i><asp:HyperLink ID="HyperLink3" NavigateUrl ="AppV_SolicitudxValidar.aspx" runat="server">Por Validar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod4 = 4 And Vg_Fac4 < 3 Then %>
                            <li><i class="ti-check"></i><asp:HyperLink ID="HyperLink4" NavigateUrl ="AppV_SolicitudxAprobar.aspx" runat="server">Por Aprobar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod5 = 5 And Vg_Fac5 < 3 Then %>
                            <li><i class="pe-7s-cart"></i><asp:HyperLink ID="HyperLink5" NavigateUrl ="AppV_SolicitudxComprar.aspx" runat="server">Por Comprar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-thumb-up"></i><asp:HyperLink ID="HyperLink6" NavigateUrl ="AppV_SolicitudxBoletoAsig.aspx" runat="server">Boleto Asignado</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod7 = 7 And Vg_Fac7 < 3 Then %>
                            <li><i class="ti-thumb-down"></i><asp:HyperLink ID="HyperLink7" NavigateUrl ="AppV_SolicitudxRechazar.aspx" runat="server">Rechazadas</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>
                    <!--GEVS 24/03/2021-->
                    <!--<li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-id-badge"></i>Pasajeros
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="ti-arrow-up"></i><a href="AppV_PasajeroNew.aspx">Alta</a></li>
                            <li><i class="ti-search"></i><a href="AppV_PasajeroSearch.aspx">Consulta</a></li>
                            <li><i class="ti-arrows-horizontal"></i><a href="AppV_PasajeroChange.aspx">Cambio</a></li>
                        </ul>
                    </li>

                    <li class="menu-title">Estadisticas</li><!-- /.menu-title -->

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-files"></i>Reportes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod8 = 8 And Vg_Fac8 < 3 Then %>
                            <li><i class="ti-agenda"></i><asp:HyperLink ID="HyperLink11" NavigateUrl ="AppV_MensualxProveedor.aspx" runat="server">Mensual por Proveedor</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-bookmark-alt"></i><asp:HyperLink ID="HyperLink12" NavigateUrl ="AppV_PorEstatus.aspx" runat="server">Por Estatus</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-book"></i><asp:HyperLink ID="HyperLink30" NavigateUrl ="AppV_MesxProvxEjercicio.aspx" runat="server">Proveedor por Ejercicio</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
    </aside>
    <!-- /#left-panel -->
    <!-- Right Panel -->
    <div id="right-panel" class="right-panel">
        <!-- Header-->
        <header id="header" class="header">
            <div class="top-left">
                <div class="navbar-header">
                    <a class="navbar-brand" href="portal.aspx"><img src="images/logo.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./"><img src="images/logo2.png" alt="Logo"></a>
                    <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>

                </div>
            </div>
             <div class="top-right">
                <div class="header-menu">
                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="images/user.png" alt="User Avatar">
                        </a>
                        <div class="user-menu dropdown-menu">
                            <a class="nav-link"><i class="fa fa- user"></i><%=vg_Name & " " & vg_LastName  %></a>
                            <a class="nav-link" href="./MiPerfil.aspx"><i class="fa fa- user"></i>Mi Perfil</a>
                            <a class="nav-link" href="./" onclick="<script> self.close(); </script>"><i class="fa fa-power -off"></i>Cerrar Sesión</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- /#header -->
        <!-- Content -->
        <div class="content">

           <form id="form1" method = "post" runat="server" target="_self">

            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title">Solicitudes / Nueva</strong>
                    </div>
                    <div class="card-body">
                        
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Pasajero</strong>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Nombre</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                                    <asp:TextBox ID="Txt_Nombre" class="form-control" runat="server" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Apellido Paterno</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                                    <asp:TextBox ID="Txt_ApPaterno" class="form-control" runat="server" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Apellido Materno</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                                    <asp:TextBox ID="Txt_ApMaterno" class="form-control" runat="server" MaxLength="50"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-10">
                                                        <asp:DropDownList ID="DDL_Secretarias" class="form-control" runat="server"></asp:DropDownList>
                                                    </div>

                                                     <div class="form-group col-md-2">
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <!-- <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#scrollmodal"><i class="fa fa-search"></i>&nbsp; Buscar</button> -->
                                                                <asp:Button ID="Btn_Buscar" runat="server" Text="Buscar" class="btn btn-success" onclick="SP_GetPasajero" />
                                                                <asp:TextBox ID="Txt_IdPasajero" runat="server" Visible="False"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <asp:GridView ID="GV_Pasajero" runat="server" Width="100%" CellPadding="4" ForeColor="#333333" 
                                                            GridLines="None" AutoGenerateColumns="False" DataKeyNames="Pas_Clave,Pas_Nombre,Pas_ApPaterno,Pas_ApMaterno"
                                                            OnSelectedIndexChanged="GV_Pasajero_SelectedIndexChanged" ShowHeaderWhenEmpty="True" EmptyDataText="No se encontraron registros">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

                                                            <Columns>

                                                                <asp:CommandField ShowSelectButton="True" SelectText="Ok" ButtonType="Image" SelectImageUrl="~/images/Edit.jpg"></asp:CommandField>

                                                                <asp:BoundField DataField="Pas_Nombre" HeaderText="NOMBRE">
                                                                    <HeaderStyle Font-Bold="True" Font-Size="Small" Width="20%"></HeaderStyle>

                                                                    <ItemStyle Font-Size="Smaller" Width="20%" HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Pas_ApPaterno" HeaderText="PATERNO">
                                                                    <HeaderStyle Font-Bold="True" Font-Size="Small" Width="20%"></HeaderStyle>

                                                                    <ItemStyle Font-Size="Smaller" Width="20%" HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Pas_ApMaterno" HeaderText="MATERNO">
                                                                    <HeaderStyle Font-Bold="True" Font-Size="Small" Width="20%"></HeaderStyle>

                                                                    <ItemStyle Font-Size="Smaller" Width="20%" HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                                                                </asp:BoundField>

                                                                <asp:BoundField DataField="Sec_Descripcion" HeaderText="SECRETARIA">
                                                                    <HeaderStyle Font-Bold="True" Font-Size="Small" Width="40%"></HeaderStyle>

                                                                    <ItemStyle Font-Size="Smaller" Width="40%" HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                                                                </asp:BoundField>


                                                            </Columns>

                                                            <EditRowStyle BackColor="#999999"></EditRowStyle>

                                                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></FooterStyle>

                                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                                                            <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White"></PagerStyle>

                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333"></RowStyle>

                                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>

                                                            <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>

                                                            <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>

                                                            <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>

                                                            <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
                                                        </asp:GridView>
                                                    </div>
                                                </div>

                                    <!-- /.table-stats -->
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud: </strong> <asp:Label ID="Lbl_Nombre" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Origen</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-sign-in"></i></div>
                                                                <asp:TextBox ID="Txt_Origen" class="form-control" runat="server" MaxLength="50"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Destino</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-sign-out"></i></div>
                                                            <asp:TextBox ID="Txt_Destino" class="form-control" runat="server" MaxLength="50"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Tipo de Vuelo</label>
                                                        <div class="input-group">
                                                            <asp:DropDownList ViewStateMode="Enabled" EnableViewState="true" ID="DDL_TipoVuelo" class="form-control" runat="server"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Fecha Vuelo Salida</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            <input type="date" class="form-control" disabled  id="dateFechaFlyExit" >
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Horario Vuelo Salida</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="ti-alarm-clock"></i></div>
                                                            <input type="time" class="form-control" disabled id="timeFechaFlyExit" >
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Fecha Vuelo Regreso</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            <input type="date" class="form-control" disabled id="dateFechaFlyRet" >
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Horario Vuelo Regreso</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="ti-alarm-clock"></i></div>
                                                            <input type="time" class="form-control" disabled id="timeFechaFlyRet" >
                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <label class=" form-control-label">Detalle de Vuelo</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-th-large"></i></div>
                                                            <asp:TextBox ID="Txt_DetailFly"  runat="server" Rows="4" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                        
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <label class=" form-control-label">Objeto Partidista</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-th-large"></i></div>
                                                            <asp:TextBox ID="Txt_ObPartido" runat="server" Rows="4" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group">
                                                        <input type="hidden" id="claveRespuesta" value="<%=Session("CodigoRespuesta")%>" />
                                                        <asp:Button ID="Btn_Aceptar" runat="server" OnClick="SP_SetSolicitudNew" class="btn btn-success" OnClientClick=" habilitarDescarga()" Text="Aceptar" />
                                                    </div>
                                                    <div class="form-group">
                                                        <button type="button" class="btn btn-primary" id="download">Descargar<i class="fa fa-cloud-download" aria-hidden="true"></i></button>
                                                    </div>
                                                </div>
                                    <!-- /.table-stats -->
                                </div>
                            </div>

                        </div>
                        
                    </div>
                    <!-- .card-body -->
                </div>
                <!-- .card -->
            </div>
            <!-- .col-md-12 -->

            <div class="modal fade" id="FechaModal" tabindex="-1" role="dialog" aria-labelledby="FechaModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="FechaModalLabel">Selecciona la Fecha</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-body">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="FechaModalRet" tabindex="-1" role="dialog" aria-labelledby="FechaModalRetLabel" aria-hidden="true">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="FechaModalRetLabel">Selecciona la Fecha</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <asp:TextBox ID="Txt_DateFlyExit" Width="0px" Height="0px" runat="server"></asp:TextBox>
                                <asp:TextBox ID="Txt_DateFlyRet" class="form-control"  MaxLength="10" runat="server"></asp:TextBox>
                                <asp:TextBox ID="Txt_HourFlyExit" runat="server"  MaxLength="5" class="form-control"></asp:TextBox>
                                <asp:TextBox ID="Txt_HourFlyRet" runat="server"  MaxLength="5" class="form-control"></asp:TextBox>
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-body">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                <script type="text/javascript">
                    function UpdateTime(time) {
                        alert(time);
                    }
                </script>
            </form>

        </div>
        <!-- /.content -->
        <div class="clearfix"></div>
        <!-- Footer -->
            <footer class="site-footer">
                <div class="footer-inner bg-white">
                    <div class="row">
                        <div class="col-sm-4 text-left">

                        </div>
                        <div class="col-sm-4 text-center">
                            <i class="fa fa-envelope"></i>
                            <asp:HyperLink ID="HyperLink16" Target ="_blank"  NavigateUrl ="https://discord.gg/tdeNj3Bneh" runat="server">Contactanos</asp:HyperLink>
                        </div>
                        <div class="col-sm-4 text-right">

                        </div>
                    </div>
                </div>
            </footer>
        <!-- /.site-footer -->
    </div>
    <!-- /#right-panel -->
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
    <script src="assets/js/main.js"></script>

    <!--  Chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/dist/Chart.bundle.min.js"></script>

    <!--Chartist Chart-->
    <script src="https://cdn.jsdelivr.net/npm/chartist@0.11.0/dist/chartist.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartist-plugin-legend@0.6.2/chartist-plugin-legend.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/jquery.flot@0.8.3/jquery.flot.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-pie@1.0.0/src/jquery.flot.pie.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-spline@0.0.1/js/jquery.flot.spline.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/simpleweather@3.1.0/jquery.simpleWeather.min.js"></script>
    <script src="assets/js/init/weather-init.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/moment@2.22.2/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.js"></script>
    <script src="assets/js/init/fullcalendar-init.js"></script>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
     <script type="text/javascript">
         $(document).ready(function () {
             $("#download").hide();
             //Deshabilitar campos antes de la captura
             $('#Txt_Origen').prop("disabled", true);
             $('#Txt_Destino').prop("disabled", true);
             $('#DDL_TipoVuelo').prop("disabled", true);
             $('#Txt_DetailFly').prop("disabled", true);
             $('#Txt_ObPartido').prop("disabled", true);
             $('#Btn_Aceptar').prop("disabled", true);

             var codigoPasajero = '<%=Session("CodigoPasajero")%>';
             //alert(codigoPasajero);
             if (codigoPasajero != '') {
                 //Habilitar campos antes de la captura
                 $('#Txt_Origen').prop("disabled", false);
                 $('#Txt_Destino').prop("disabled", false);
                 $('#DDL_TipoVuelo').prop("disabled", false);
                 $('#Txt_DetailFly').prop("disabled", false);
                 $('#Txt_ObPartido').prop("disabled", false);
                 $('#Btn_Aceptar').prop("disabled", false);
             }
             
             var now = new Date();
             var day = ("0" + now.getDate()).slice(-2);
             var month = ("0" + (now.getMonth() + 1)).slice(-2);
             var today = now.getFullYear() + "-" + (month) + "-" + (day);

             $('#dateFechaFlyExit').change(function () {
                 var fecha = new Date();
                 var anio = fecha.getFullYear();

                 var value = $(this).val();
                 var vl_dia = new Date(value).getDate() + 1;
                 var vl_mes = new Date(value).getMonth() + 1;
                 var vl_anio = new Date(value).getFullYear();

                 if (vl_dia.toString.length == 1) {
                     vl_dia = "0" + vl_dia;
                 }

                 if (vl_mes.toString.length == 1) {
                     vl_mes = "0" + vl_mes;
                 }

                 $("#Txt_DateFlyExit").val($('#dateFechaFlyExit').val());

                 if ($('#DDL_TipoVuelo').val() == 2) {
                     $("#dateFechaFlyRet").attr({ "min": $("#dateFechaFlyExit").val() });
                     $("#dateFechaFlyRet").val($("#dateFechaFlyExit").val());
                     $('#Txt_DateFlyRet').val($('#dateFechaFlyRet').val());
                 }
             });

             $('#dateFechaFlyRet').change(function () {
                 var value1 = $(this).val();
                 var vl_dia1 = new Date(value1).getDate() + 1;
                 var vl_mes1 = new Date(value1).getMonth() + 1;
                 var vl_anio1 = new Date(value1).getFullYear();

                 if (vl_dia1.toString.length == 1) {
                     vl_dia1 = "0" + vl_dia1;
                 }

                 if (vl_mes1.toString.length == 1) {
                     vl_mes1 = "0" + vl_mes1;
                 }

                 $('#Txt_DateFlyRet').val($('#dateFechaFlyRet').val());

             });

             $('#timeFechaFlyExit').change(function () {
                 $('#Txt_HourFlyExit').val($('#timeFechaFlyExit').val());

             });

             $('#timeFechaFlyRet').change(function () {
                 $('#Txt_HourFlyRet').val($('#timeFechaFlyRet').val());

             });

             $('#DDL_TipoVuelo').change(function () {
                 if ($('#DDL_TipoVuelo').val() == 1) {
                     $('#Txt_DateFlyExit').val("");
                     $('#Txt_DateFlyRet').val("");
                     $('#Txt_HourFlyExit').val("");
                     $('#Txt_HourFlyRet').val("");
                     $('#dateFechaFlyExit').prop("disabled", false);
                     $('#timeFechaFlyExit').prop("disabled", false);
                     $('#dateFechaFlyRet').prop("disabled", true);
                     $('#timeFechaFlyRet').prop("disabled", true);
                     $('#dateFechaFlyRet').val("");
                     $('#timeFechaFlyRet').val("");
                     $('#Txt_HourFlyRet').val("");
                     $('#Txt_DateFlyRet').val("");
                 }
                 if ($('#DDL_TipoVuelo').val() == 2) {
                     $('#dateFechaFlyExit').prop("disabled", false);
                     $('#timeFechaFlyExit').prop("disabled", false);
                     $('#dateFechaFlyRet').prop("disabled", false);
                     $('#timeFechaFlyRet').prop("disabled", false);

                     $("#dateFechaFlyRet").attr({ "min": $("#dateFechaFlyExit").val() });
                     $("#dateFechaFlyRet").val($("#dateFechaFlyExit").val());
                     $('#Txt_DateFlyRet').val($('#dateFechaFlyRet').val());
                 }
             });
                          
             $('#Btn_Buscar').click(function () {
                 //DesHabilitar campos antes de la captura
                 $('#Txt_Origen').prop("disabled", true);
                 $('#Txt_Destino').prop("disabled", true);
                 $('#DDL_TipoVuelo').prop("disabled", true);
                 $('#Txt_DetailFly').prop("disabled", true);
                 $('#Txt_ObPartido').prop("disabled", true);
                 $('#Btn_Aceptar').prop("disabled", true);

             });

             //$('#GV_Pasajero').on('click', 'tr td', function (evt) {
             //    var codigo = $(this).parents("tr").find("td").eq(1).text();
             //    alert(codigo);
             //    if (codigo != "") {
             //        //Habilitar campos antes de la captura
             //        $('#Txt_Origen').prop("disabled", false);
             //        $('#Txt_Destino').prop("disabled", false);
             //        $('#DDL_TipoVuelo').prop("disabled", false);
             //        $('#Txt_DetailFly').prop("disabled", false);
             //        $('#Txt_ObPartido').prop("disabled", false);
             //        $('#Btn_Aceptar').prop("disabled", false);    
             //    }

             //});            


             $('#download').click(function () {

                 $.ajax({
                     type: "POST",
                     url: "ExcelSevice.aspx/getNombreFile",
                     data: '{folio: "' + $("#claveRespuesta").val() + '" }',
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (r) {
                         //Convert Base64 string to Byte Array.
                         DownloadFile(r.d);
                     }
                 });

             });

         });

         $('#download').attr('disabled', true);

         var codigo = '<%=Session("CodigoRespuesta")%>';
         if (codigo != '') {
             habilitarDescarga();
         }
         function habilitarDescarga() {
             $('#download').attr('disabled', false);
         } 

         function DownloadFile(fileName) {
            // fileName = 'ReporteEvento_' + $("#claveRespuesta").val()+'.xlsx';
             
             var Datos = { Folio: this.codigo, Fecha: "20/01/2021", Pasajero: "Pasajero: Adrian Lopez de Leon", Vuelo: "Vuelo: " + $("#DDL_TipoVuelo").val(), Destino: "Destino: " + $("#Txt_Destino").val(), FecSalida: "Fecha de Salida: " + $("#Txt_DateFlyExit").val(), FecRegreso: "Fecha de Regreso: " + $("#Txt_DateFlyRet").val() };
             var jSon = JSON.stringify({ jsonData: Datos });
             $.ajax({
                 type: "POST",
                 url: "ExcelSevice.aspx/DescargaReporteVuelos",
                 data: jSon,
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (r) {
                     //Convert Base64 string to Byte Array.
                     var bytes = Base64ToBytes(r.d);

                     //Convert Byte Array to BLOB.
                     var blob = new Blob([bytes], { type: "application/octetstream" });

                     //Check the Browser type and download the File.
                     var isIE = false || !!document.documentMode;
                     if (isIE) {
                         window.navigator.msSaveBlob(blob, fileName);
                     } else {
                         var url = window.URL || window.webkitURL;
                         link = url.createObjectURL(blob);
                         var a = $("<a />");
                         a.attr("download", fileName);
                         a.attr("href", link);
                         $("body").append(a);
                         a[0].click();
                         $("body").remove(a);
                     }
                 }
             });

         };
         function Base64ToBytes(base64) {
             var s = window.atob(base64);
             var bytes = new Uint8Array(s.length);
             for (var i = 0; i < s.length; i++) {
                 bytes[i] = s.charCodeAt(i);
             }
             return bytes;
         };


     </script>

</body>
</html>
