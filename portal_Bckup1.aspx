<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>

<script runat="server">
    Dim gl_Intentos As Integer
    Dim vg_Name As String = ""
    Dim vg_LastName As String = ""
    Dim permisoV As Integer=0
    Dim permisoI As Integer=0
    Dim permisoE As Integer=0
    Dim permisoC As Integer=0

    Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)

        If Not Session("UsuAppV") <> "" Then
            Response.Write("<script>window.open('errorSesion.aspx',target='_self');<" & "/" & "script>")
        End If

        'If Session("UsuAppV") = "Admin" Or Session("UsuAppV") = "IRVINMADER" Or Session("UsuAppV") = "MANAGELMF" Or Session("UsuAppV") = "ALELAMAESC" Then
        SP_GetPermiso()
        'End If
        If Not Page.IsPostBack() Then

        End If
    End Sub

    Sub SP_GetPermiso()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "App_SPGetPortal"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            'Parámetros si hubieran
            Dim miParam As New SqlParameter("@Usu_clave", SqlDbType.VarChar)
            miParam.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam)
            coDetalle.Parameters("@Usu_clave").Value = Session("UsuAppV")


            'Ejecutar el Store Procedure
            Dim registro As SqlDataReader = coDetalle.ExecuteReader

            While registro.Read
                vg_Name = registro("Usu_Nombre").ToString
                vg_LastName = registro("Usu_ApPaterno").ToString
                Select Case CInt(registro("ID_Aplicacion").ToString)
                    Case 1
                        permisoV = 1
                    Case 2
                        permisoI = 1
                    Case 3
                        permisoE = 1
                    Case 4
                        permisoC = 1
                End Select

            End While

            registro.Close()
            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

</script>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Sistema Smart de Solicitudes</title>
        <meta name="description" content="Sistema Smart de Solicitudes">
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

                                                        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>

                                                            <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
</head>
<body class="bg-red" oncontextmenu="return false" onkeydown="return false">
             
        <!-- Header-->
        <header id="header" class="header">
            <div class="top-right">
                <div class="header-menu">
                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="images/user.png" alt="User Avatar">
                        </a>

                        <div class="user-menu dropdown-menu">
                            <a class="nav-link"><i class="fa fa- user"></i><%=vg_Name & " " & vg_LastName  %></a>
                            <a class="nav-link" href="./miperfil.aspx"><i class="fa fa- user"></i>Mi Perfil</a>
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
                        <strong class="card-title">Sistema Smart De Solicitudes Del CEN Del PRI </strong>
                    </div>
                    
                    <div class="card-body">
                        <div class="row">
                            <%if permisoC = 1 %>
                       <div class="col-md-3">
                            <div class="card">
                                <div class="card-header bg-success">
                                        <li class="list-group-item">
                                            <a href="index_Compras.aspx"> <i class="fa fa-shopping-cart"></i> <strong class="card-title text-center"> Compras</strong></a>
                                        </li>
                                </div>
                            </div>
                        </div>
                            <%End If %>
                             <%if permisoE = 1 %>
                        <div class="col-md-3">
                            <div class="card">
                                <div class="card-header bg-success">
                                        <li class="list-group-item">
                                            <a href="App_Eventos/index_Eventos.aspx"> <i class="fa fa-users"></i> <strong class="card-title text-center"> Eventos</strong></a>
                                        </li>
                                </div>
                            </div>
                        </div>
                             <%End If %>
                             <%if permisoI = 1 %>
                        <div class="col-md-3">
                            <div class="card">
                                <div class="card-header bg-success">
                                        <li class="list-group-item">
                                            <a href="index_Insumos.aspx"> <i class="fa ti-ruler-pencil"></i> <strong class="card-title text-center">Insumos</strong></a>
                                        </li>
                                </div>
                            </div>
                        </div>
                  <%End If %>
                        <div class="col-md-3">
                            <div class="card">
                                <div class="card-header bg-success">
                                  <ul class="list-group list-group-flush">
                                        <li class="list-group-item">
                                            <asp:HyperLink ID="HyperLink1" NavigateUrl="~/index.aspx" runat="server"> <i class="fa fa-plane"></i> <strong class="card-title text-center"> Vuelos</strong></asp:HyperLink>
                                           
                                        </li>
                                    </ul>
                                </div>
                               <!-- <div class="card-body text-white bg-light">
                                    <p class="card-text text-black-50">Servicio de Vuelos.</p>
                                </div>-->
                            </div>
                        </div>
                    </div>
                    </div>
                    <!-- .card-body -->
                </div>
                <!-- .card -->
            </div>
            <!-- .col-md-12 -->

            </form>

        </div>
                    
    <script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
    <script src="assets/js/main.js"></script>

</body>
</html>
