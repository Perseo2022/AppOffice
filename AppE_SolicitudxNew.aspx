﻿<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>

<script runat="server">
    Dim vg_Name As String = ""
    Dim vg_LastName As String = ""
    'Variables de Permisos
    Dim Vg_mod1 As Integer
    Dim Vg_mod2 As Integer
    Dim Vg_mod3 As Integer
    Dim Vg_mod4 As Integer
    Dim Vg_mod5 As Integer
    Dim Vg_mod6 As Integer
    Dim Vg_mod7 As Integer
    Dim Vg_mod8 As Integer
    Dim Vg_mod9 As Integer
    Dim Vg_mod10 As Integer

    Dim Vg_Fac1 As Integer
    Dim Vg_Fac2 As Integer
    Dim Vg_Fac3 As Integer
    Dim Vg_Fac4 As Integer
    Dim Vg_Fac5 As Integer
    Dim Vg_Fac6 As Integer
    Dim Vg_Fac7 As Integer
    Dim Vg_Fac8 As Integer
    Dim Vg_Fac9 As Integer
    Dim Vg_Fac10 As Integer


    Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'If Not Session("UsuAppV") <> "" Then
        '    Server.Transfer("portal.aspx")
        'End If
        'Dim dsColumnas As New DataSet
        If Not Page.IsPostBack() Then
            SP_GetPermiso()
            'Obtiene Tipo de Requerimiento
            'SP_GetReq()
            'Obtiene Tipo de Vuelo
            'SP_GetTipoVuelo()
            'Obtienes Secretarias
            SP_GetSecretarias()
            'ISP_GetProdCat()
            'ISP_GetInsumosTipo()
            'ISP_GetEnlaces()
            'ISP_GetUniPptal()
        End If
    End Sub

    Sub SP_GetPermiso()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppV_SPGetPermiso"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@vp_UsuUsuario", SqlDbType.Char)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@vp_UsuUsuario").Value = Session("UsuAppV")

        Dim miParam1 As New SqlParameter("@vp_PerClave", SqlDbType.Char)
        miParam1.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam1)
        coDetalle.Parameters("@vp_PerClave").Value = CInt(Session("UsuPer"))

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        While registro.Read
            vg_Name = registro("Usu_Nombre").ToString
            vg_LastName = registro("Usu_ApPaterno").ToString
            Select Case CInt(registro("Mod_Clave").ToString)
                Case 1
                    Vg_mod1 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac1 = CInt(registro("Fac_Clave").ToString)
                Case 2
                    Vg_mod2 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac2 = CInt(registro("Fac_Clave").ToString)
                Case 3
                    Vg_mod3 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac3 = CInt(registro("Fac_Clave").ToString)
                Case 4
                    Vg_mod4 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac4 = CInt(registro("Fac_Clave").ToString)
                Case 5
                    Vg_mod5 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac5 = CInt(registro("Fac_Clave").ToString)
                Case 6
                    Vg_mod6 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac6 = CInt(registro("Fac_Clave").ToString)
                Case 7
                    Vg_mod7 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac7 = CInt(registro("Fac_Clave").ToString)
                Case 8
                    Vg_mod8 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac8 = CInt(registro("Fac_Clave").ToString)
                Case 9
                    Vg_mod9 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac9 = CInt(registro("Fac_Clave").ToString)
                Case 10
                    Vg_mod10 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac10 = CInt(registro("Fac_Clave").ToString)
            End Select

        End While

        registro.Close()
        myConnection.Close()

    End Sub



    Sub SP_GetSecretarias()
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppV_SPGetSecretarias"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Parámetros si hubieran
        'Dim miParam As New SqlParameter("@Usu_Clave", SqlDbType.VarChar)
        'miParam.Direction = ParameterDirection.Input
        'coDetalle.Parameters.Add(miParam)
        'coDetalle.Parameters("@Usu_Clave").Value = vl_cveusu

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        DDL_Secretarias.DataTextField = "Sec_Descripcion"
        DDL_Secretarias.DataValueField = "Sec_Clave"
        DDL_Secretarias.DataSource = registro
        DDL_Secretarias.DataBind()
        DDL_Secretarias.Items.Insert(0, "Selecciona una Secretaria")
        DDL_Secretarias.SelectedIndex = 0


        registro.Close()
        myConnection.Close()
    End Sub





</script>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
 <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>App Eventos</title>
    <meta name="description" content="Aplicacion de Insumos">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="https://i.imgur.com/QRAUqs9.png">
    <link rel="shortcut icon" href="https://i.imgur.com/QRAUqs9.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/normalize.css@8.0.0/normalize.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pixeden-stroke-7-icon@1.2.3/pe-icon-7-stroke/dist/pe-icon-7-stroke.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.2.0/css/flag-icon.min.css">
    <link rel="stylesheet" href="./../assets/css/cs-skin-elastic.css">
    <link rel="stylesheet" href="./../assets/css/style.css">
    <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
    <link href="https://cdn.jsdelivr.net/npm/chartist@0.11.0/dist/chartist.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/jqvmap@1.5.1/dist/jqvmap.min.css" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/weathericons@2.1.0/css/weather-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.css" rel="stylesheet" />
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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
</head>

<body>
    <!-- Left Panel -->
    <aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default">
            <div id="main-menu" class="main-menu collapse navbar-collapse">
                 <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="index_Eventos.aspx"><i class="menu-icon fa fa-laptop"></i>Tablero </a>
                    </li>
                    <li class="menu-title">Insumos</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon fa fa-cogs"></i>Solicitudes
                        </a>
                                  <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod1 = 1 And Vg_Fac1 < 3 Then %>
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1" NavigateUrl ="AppE_SolicitudxNew.aspx" runat="server">Nueva</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                            <li><i class="pe-7s-cash"></i><asp:HyperLink ID="HyperLink2" NavigateUrl ="CoordinadorEnlace.aspx" runat="server">VoBo Cordinador de Enlace</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                            <li><i class="ti-pencil-alt"></i><asp:HyperLink ID="HyperLink3" NavigateUrl ="RevisionEnlace.aspx" runat="server">Revision Area Enlace</asp:HyperLink></li>
                            <% End If %>
                           
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-thumb-up"></i><asp:HyperLink ID="HyperLink6" NavigateUrl ="VoBoSubBase.aspx" runat="server">VoBo SubBase</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                    <li class="menu-title">Estadisticas</li><!-- /.menu-title -->

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-files"></i>Reportes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod8 = 8 And Vg_Fac8 < 3 Then %>
                            <li><i class="ti-agenda"></i><asp:HyperLink ID="HyperLink11" NavigateUrl ="AppV_SolicitudxRechazar.aspx" runat="server">Mensual por Proveedor</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-bookmark-alt"></i><asp:HyperLink ID="HyperLink12" NavigateUrl ="AppV_ReportResumen.aspx" runat="server">Autorizados por Agencia</asp:HyperLink></li>
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
                    <a class="navbar-brand" href="index_Eventos.aspx"><img src="../../images/logoEventos.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./"><img src="../../images/logo.png" alt="Logo"></a>
                    <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>

                </div>
            </div>

            <div class="top-right">

                <div class="header-menu">

                    <div class="header-left">
                            
                        <i class="fa fa-bell"></i>
                        <h6 class="por-title"><%=vg_Name & " " & vg_LastName  %></h6>

                    </div>

                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="../../images/admin.jpg" alt="User Avatar">
                        </a>

                        <div class="user-menu dropdown-menu">
                            <a class="nav-link" href="#"><i class="fa fa- user"></i>Mi Perfil</a>

                            <a class="nav-link" href="#"><i class="fa fa-power -off"></i>Logout</a>
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
                                    <strong>Solicitud</strong>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                       <div class="form-group">
                                                        <div class="input-group">
                                                            <label class=" form-control-label">Secretarias</label>
                                                            <div class="input-group">
                                                                <asp:DropDownList ID="DDL_Secretarias" class="form-control" runat="server"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                     <div class="form-row">
    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Fecha Inicio</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></div>
                                                            <input type="date" class="form-control" id="FecInicio" >
                                                        </div>
                                                    </div>
                                          <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Fecha Fin</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></div>
                                                           <input type="date" class="form-control" id="FecFin" >
                                                        </div>
                                                    </div>
                                          <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Hora Inicio</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-clock-o" aria-hidden="true"></i></div>
                                                            <input type="text" class="form-control" id="HoraInicio" >
                                                        </div>
                                                    </div>
                                          <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Hora Fin</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-clock-o" aria-hidden="true"></i></div>
                                                            <input type="text" class="form-control" id="HoraFin" >
                                                        </div>
                                                    </div>
                                          <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Numero de Personas</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-users" aria-hidden="true"></i></div>
                                                            <input type="text" class="form-control" id="NumPersonas" >
                                                        </div>
                                                    </div>
                                         
    
  </div>
                                    <div class="form-row">
                                         <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Lugar</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-map-marker" aria-hidden="true"></i></div>
                                                           
                                                             <select id="lugar" class="form-control" ">
                                                                <option value="1">lugar  1</option>
                                                                  <option value="1">Lugar 2 </option>
                                                                  <option value="1">Lugar 3</option>

                                                            </select>
                                                        </div>
                                                    </div>
                                        </div>
                                   

                                     <div class="form-row">
                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Tipo de Montaje </label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-th-large"></i></div>
                                                           <select id="idMontaje" class="form-control" ">
                                                                <option value="1">montaje 1</option>

                                                            </select>
                                                        </div>
                                                    </div>
                                          
                                        <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Nombre del evento</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-id-card" aria-hidden="true"></i></div>
                                                            <input type="text" class="form-control" id="nombreEvento" >
                                                        </div>
                                                    </div>
                                        </div>
                                    <hr />

                                    			<div class="form-row">
                                                     <div class="form-group col-md-4">
					<label class=" form-control-label">Tipo Insumos</label>
					<div class="input-group">
						<div class="input-group-addon"><i class="fa fa-th-large"></i></div>
						<select id="SelectTipoInsumos" class="form-control">
						</select>
					</div>
				</div>
                                                     <div class="form-group col-md-4">
					<label class=" form-control-label">Insumos</label>
					<div class="input-group">
						<div class="input-group-addon"><i class="fa fa-th-large"></i></div>
						<select id="SelectInsumos" class="form-control">
						</select>
					</div>
				</div>
	
				<div class="form-group col-md-2">
					<label class=" form-control-label">Cantidad</label>
					<div class="input-group">
						<div class="input-group-addon"><i class="fa fa-id-card" aria-hidden="true"></i></div>
						<input type="text" class="form-control" id="cantidad">
					</div>
				</div>

				<div class="col-auto">
					<button id="btnAgregar" class="btn btn-primary mb-2">Agregar</button>
				</div>
			</div>

            <div class="form-row">
                <div class="form-group col-md-4">
                    <label class=" form-control-label">Telefono</label>
                    <div class="input-group">
                        <div class="input-group-addon"><i class="fa fa-phone"></i></div>
                        <asp:TextBox ID="Txt_Telefono" runat="server"  MaxLength="10" class="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group col-md-4">
                    <label class=" form-control-label">Extension</label>
                    <div class="input-group">
                        <div class="input-group-addon"><i class="fa fa-phone"></i></div>
                            <asp:TextBox ID="Txt_Extension" class="form-control" runat="server"  MaxLength="10"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group col-md-4">
                    <label class=" form-control-label">Edificio / Piso</label>
                    <div class="input-group">
                        <div class="input-group-addon"><i class="fa fa-building-o"></i></div>
                        <asp:TextBox ID="Txt_Edificio" runat="server"  MaxLength="80" class="form-control"></asp:TextBox>
                        <asp:TextBox ID="Txt_Piso" class="form-control"  MaxLength="30" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>

			<table id="lista_insumos" class="table table-striped">
				<thead>
					<tr>
						<th>ID_Insumo</th>
						<th> Insumo </th>
						<th> cantidad </th>
						<th> </th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>

                                     <div class="form-group">
                                                        <label class=" form-control-label">Objeto Partidista</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-th-large"></i></div>
                                                            <asp:TextBox ID="Txt_ObPartido" runat="server" Rows="2" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>

                                    
                                           <div class="form-group ">
     <button class="btn  btn-success" id="btnSolicitarEvento">Solicitar Evento</button>
            <button id="btnDescargar" class="btn  btn-primary  ">Descargar <i class="fa fa-cloud-download" aria-hidden="true"></i></button>

  </div>

           
                                </div>
                            </div>
                        <!-- /Solicitud -->
                        </div>

                      
                    </div>
                    <!-- .card-body -->
                </div>
                <!-- .card -->
            </div>
            <!-- .col-md-12 -->

            </form>

        </div>
        <!-- /.content -->
        <div class="clearfix"></div>
        <!-- Footer -->
        <footer class="site-footer">
            <div class="footer-inner bg-white">
                <div class="row">
                    <div class="col-sm-6">
                        Copyright &copy; 2018 Empresa
                    </div>
                    <div class="col-sm-6 text-right">
                        Designed by <a href="https://colorlib.com">Empresa</a>
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
    <script src="./../assets/js/main.js"></script>

    <!--  Chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/dist/Chart.bundle.min.js"></script>

    <!--Chartist Chart-->
    <script src="https://cdn.jsdelivr.net/npm/chartist@0.11.0/dist/chartist.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartist-plugin-legend@0.6.2/chartist-plugin-legend.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/jquery.flot@0.8.3/jquery.flot.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-pie@1.0.0/src/jquery.flot.pie.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-spline@0.0.1/js/jquery.flot.spline.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/simpleweather@3.1.0/jquery.simpleWeather.min.js"></script>
    <script src="./../assets/js/init/weather-init.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/moment@2.22.2/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.js"></script>
    <script src="./../assets/js/init/fullcalendar-init.js"></script>

    	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
			integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
			crossorigin="anonymous"></script>
      <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="../../js/Insumos.js"></script>
    <script type="text/javascript">

   


     
        $(document).ready(function () {
            insumos();
            loadInsumos();
            dowloadReport();
            $('form').submit(function (event) {
                event.preventDefault();
              
            });

            $('#btnSolicitarEvento').click(function () {
                var listIsumos = new Array();
                $("#lista_insumos tbody tr").each(function (index) {
                    Insumo_Eventos = {
                        IdEvento: 0,
                        IdInsumo: $(this).children("td").eq(0).text(),
                        Cantidad: $(this).children("td").eq(2).text()
                    }
                    listIsumos.push(Insumo_Eventos);
                });
                
                var Datos = {
                    IdArea: $("#DDL_Secretarias").val(),
                    FechaInicio: $("#FecInicio").val(),
                    FechaFin: $("#FecFin").val(),
                    Hora_Inicio: $("#HoraInicio").val(),
                    Hora_Fin: $("#HoraFin").val(),
                    NumPersonas: $("#NumPersonas").val(),
                    Lugar: $("#lugar").val(),
                    TipoMontaje: $("#idMontaje").val(),
                    NombreEvento: $("#nombreEvento").val(),
                    Objetivo: $("#Txt_ObPartido").val(),
                    listInsumos: listIsumos
                };

               
                var jSon = JSON.stringify({ eventos: Datos });
                $.ajax({
                    type: "POST",
                    url: "DatosService.aspx/SaveEvento",
                    data: jSon,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        swal("Listo!!", "Solicitud creada correctamente!", "success");
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        swal("Error!!", "Llene los campos requeridos!", "error");
                    }
                   
                });
            });
         
        });
    </script>
</body>
</html>
