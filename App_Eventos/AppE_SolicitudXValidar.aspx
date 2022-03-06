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
        If Session("UsuAppV") = "" Then
            FormsAuthentication.SignOut()
            Response.Redirect("./../login.aspx")
        End If
        'Dim dsColumnas As New DataSet
        If Not Page.IsPostBack() Then
            SP_GetPermiso()
            'Obtiene Tipo de Requerimiento
            'SP_GetReq()
            'Obtiene Tipo de Vuelo
            'SP_GetTipoVuelo()
            'Obtienes Secretarias
            'SP_GetSecretarias()
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
        coDetalle.CommandText = "App_SPGetPermisoByUser"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@UsuAppV", SqlDbType.VarChar)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@UsuAppV").Value = Session("UsuAppV")

        Dim miParam1 As New SqlParameter("@IdApp", SqlDbType.Int)
        miParam1.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam1)
        coDetalle.Parameters("@IdApp").Value = 3

        Dim miParam2 As New SqlParameter("@IdModulo", SqlDbType.Int)
        miParam2.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam2)
        coDetalle.Parameters("@IdModulo").Value = 4

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
            #listaEventos tr{
            cursor:pointer;
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
                    <li class="menu-title">Eventos</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon fa fa-cogs"></i>Solicitudes
                        </a>
                         <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod1 = 1 And Vg_Fac1 < 3 Then %>
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1" NavigateUrl ="AppE_SolicitudxNew.aspx" runat="server">Nueva</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                            <li><i class="ti-zoom-in"></i><asp:HyperLink ID="HyperLink2" NavigateUrl ="AppE_SolicitudXValidar.aspx" runat="server">Por Validar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                            <li><i class="ti-pencil-alt"></i><asp:HyperLink ID="HyperLink3" NavigateUrl ="AppE_SolicitudXAprobar.aspx" runat="server">Por Aprobar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod4 = 4 And Vg_Fac4 < 3 Then %>
                            <li><i class="ti-check"></i><asp:HyperLink ID="HyperLink6" NavigateUrl ="AppE_SolicitudxAprobarRM.aspx" runat="server">Por Aprobar RM</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod5 = 5 And Vg_Fac5 < 3 Then %>
                            <li><i class="pe-7s-cart"></i><asp:HyperLink ID="HyperLink8" NavigateUrl ="AppE_SolicitudxSurtir.aspx" runat="server">Por Surtir</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-thumb-up"></i><asp:HyperLink ID="HyperLink10" NavigateUrl ="AppE_SolicitudxVoBo.aspx" runat="server">VoBo</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>
                    <li class="menu-title">Estadisticas</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-files"></i>Reportes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod7 = 7 And Vg_Fac7 < 3 Then %>
                            <li><i class="ti-agenda"></i><asp:HyperLink ID="HyperLink11" NavigateUrl ="AppE_Reportes.aspx" runat="server">Aprobados</asp:HyperLink></li>
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
                    <a class="navbar-brand" href="./../portal.aspx"><img src="../../images/logoEventos.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./"><img src="../../images/logo.png" alt="Logo"></a>
                    <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>
                </div>
            </div>
            <div class="top-right">
                <div class="header-menu">   
                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="../images/user.png" alt="User Avatar">
                        </a>

                        <div class="user-menu dropdown-menu">
                            <a class="nav-link"><i class="fa fa- user"></i><%=vg_Name & " " & vg_LastName  %></a>
                            <a class="nav-link" href="../MiPerfil.aspx"><i class="fa fa- user"></i>Mi Perfil</a>
                            <a class="nav-link" href="../login.aspx" onclick="<script> self.close(); </script>"><i class="fa fa-power -off"></i>Logout</a>
                        </div>
                    </div>

                </div>
            </div>
        </header>
        <!-- /#header -->
        <!-- Content -->
        <div class="content">

           <form id="form1" method = "post" runat="server" target="_self">
                <input type="hidden" name="IdStatusActual" id="IdStatusActual" value="1">
               <input type="hidden" name="IdStatusActualizar" id="IdStatusActualizar" value="2">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title">Solicitudes / Validar</strong>
                    </div>
                    <div class="card-body">
                        
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud</strong>
                                </div>
                                <div class="card-body card-block">
                                     <table id="listaEventos" class="table table-striped">
				<thead>
					<tr>
						<th>ID</th>
						<th> Nombre </th>
						<th> Fecha Inicio </th>
                        <th> Fecha Fin </th>
						<th> Num Personas</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
                                </div>
                            </div>

                              <div class="card">
  <div class="card-header">
    Detalle Evento
  </div>
  <div class="card-body">

  <div id="DvDatos">
           <input type="hidden" name="IdEvento" id="IdEvento" value="">
      <div class="form-row">

                                            <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Fecha Inicio</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></div>
                                                            <input type="text" class="form-control" id="Fecinicio" >
                                                        </div>
                                                    </div>
                                          <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Fecha Fin</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></div>
                                                           <input type="text" class="form-control" id="FecFin" >
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
                                                            <input type="text" class="form-control" id="numPersonas" >
                                                        </div>
                                                    </div>

                                         
    
  </div>
          <div class="form-row">
                                         <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Lugar</label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-map-marker" aria-hidden="true"></i></div>
                                                             <input type="text" class="form-control" id="NomLugar" >
                                                        </div>
                                                    </div>
                                        </div>
      <div class="form-row">
                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Tipo de Montaje </label>
                                                        <div class="input-group">
                                                             <div class="input-group-addon"><i class="fa fa-th-large"></i></div>
                                                            <input type="text" class="form-control" id="NTipoMontaje" >
                                                          
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
       <div class="form-row">
                  <table id="listaInsumos" class="table table-striped">
				<thead>
					<tr>
						<th> Codigo </th>
						<th>Descripcion</th>
                        <th>Medida</th>
                        <th> Cantidad </th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
          </div>
          </div>
       <div class="form-row">
        <div class="form-group  col-md-4">
    <label for="fileUpload">Selecciona el archivo</label>
    <input type="file" class="form-control-file" id="fileUpload" accept=".pdf, .gif, .jpg, .jpeg, .xls, .xlsx, .png">
  </div>
    <div class="form-group  col-md-2">
    <label for="BtnCargar">Ok</label>
    <button id="BtnCargar" class="btn btn-primary">Subir Archivo</button>
  </div>
           <div class="form-group col-md-6">
                                                       <label for="nameFile">Archivo cargado</label>
                                                        <div class="input-group">
                                                             <a href="#" id="nameFile" ><i class="fa fa-file-pdf-o" aria-hidden="true"> <p id="fileName"></p></i></a> 
                                                        </div>
                                                    </div>
  </div>
    <button id="BtnAceptar" class="btn btn-success">Aceptar</button>
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
                     <!--
                                <div class="col-sm-6">
                                    Copyright &copy; 2018 Empresa
                                </div>
                                <div class="col-sm-6 text-right">
                                    Designed by <a href="https://colorlib.com">Empresa</a>
                                </div>
                                -->
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
    <script type="text/javascript" src="../../js/Eventos.js"></script>
          <link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet" />
     <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
          
            usuario = '<%=Session("UsuAppV")%>';
            facultad = <%=Vg_Fac2%>;
            eventos(usuario, facultad);
           
            $('form').submit(function (event) {
                event.preventDefault();
            });

            function getObgetivobyId(id) {
                $.ajax({
                    type: "POST",
                    url: "DatosService.aspx/GetEventoById",
                    data: JSON.stringify({ IdEvento: id }),
                    //data: ,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data != null) {
                            var EventoDto = data.d;
                            $("#IdEvento").val(id);
                            $("#nombre").val(EventoDto.NombreEvento);
                            $("#numPersonas").val(EventoDto.SecDescripcion);
                            $("#Fecinicio").val(EventoDto.FechaInicio_S);
                            $("#HoraInicio").val(EventoDto.Hora_Inicio);
                            $("#FecFin").val(EventoDto.FechaFin_S);
                            $("#HoraFin").val(EventoDto.Hora_Fin);
                            $("#Objetivo").val(EventoDto.Objetivo);
                            $("#NomLugar").val(EventoDto.NomLugar);
                            $("#NTipoMontaje").val(EventoDto.NTipoMontaje);
                            $("#nombreEvento").val(EventoDto.NombreEvento);
                            if ($("#nameFile")[0]) {
                                $("#nameFile").attr('href', EventoDto.urlFile);
                                $("#fileName").text(EventoDto.nameFile);
                            }
                           // getInsumosEvento(id);
                        }
                    }
                });
            }

            $('#BtnCargar').on('click', function () {
                var files = $("#fileUpload").get(0).files;
                if (files.length > 0 && $("#IdEvento").val().length > 0) {
                    var data = new FormData();
                    data.append('data', files[0]);
                    data.append('IdEvento', $("#IdEvento").val());
                    var ajaxRequest = $.ajax({
                        type: "POST",
                        url: "../FileService.aspx/uploadfile",
                        contentType: false,
                        processData: false,
                        data: data,
                        success: function (data) {
                            swal("Ok!!", "Archivo cargado!", "success");
                            getObgetivobyId($("#IdEvento").val());
                        },
                        error: function (xhr, ajaxoptions, thrownerror) {
                            swal("!!", "Error al cargar el archivo!", "error");
                        },
                        asyn: false
                        //data: data
                    });

                    ajaxRequest.done(function (xhr, textStatus) {
                        // Do other operation
                    });
                } else {
                    swal("!!", "Seleccionar un archivo o evento!", "error");
                }
            });
        });
    </script>
</body>
</html>
