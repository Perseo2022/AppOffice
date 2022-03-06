 <%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>

<script runat="server">
    Dim gl_Intentos As Integer

    Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)

        If Not Page.IsPostBack() Then

        End If
    End Sub

    Sub SP_GeTUsuario()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPGeTUsuario"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            'Parámetros si hubieran
            Dim miParam As New SqlParameter("@vp_UsuUsuario", SqlDbType.Char)
            miParam.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam)
            coDetalle.Parameters("@vp_UsuUsuario").Value = Txt_Usuario.Text.Trim

            Dim miParam1 As New SqlParameter("@vp_UsuPwd", SqlDbType.Char)
            miParam1.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam1)
            coDetalle.Parameters("@vp_UsuPwd").Value = Txt_Password.Text.Trim

            'Ejecutar el Store Procedure
            Dim registro As SqlDataReader = coDetalle.ExecuteReader

            If registro.Read Then

                If (registro("Usu_Usuario").ToString = Txt_Usuario.Text.Trim) And (registro("Usu_Pwd").ToString = Txt_Password.Text.Trim) Then
                    Session("UsuAppV") = registro("Usu_Usuario").ToString
                    Session("UsuPer") = registro("per_clave").ToString
                    Response.Write("<script>window.open('portal.aspx',target='_self');<" & "/" & "script>")
                Else
                    Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
                End If

            Else
                Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
            End If

            registro.Close()
            myConnection.Close()

        Catch ex As Exception
            'Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
            Response.Write("<script>window.alert('" & ex.StackTrace.ToString & "');<" & "/" & "script>")
        End Try

    End Sub

</script>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head >
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
<body class="bg-dark" oncontextmenu="return false">
    <form id="form1" method = "post" runat="server">                
    <p></p>
                <div class="sufee-login d-flex align-content-center flex-wrap">
                    <div class="container">
                        <div class="login-content">
                            <div class="card">
                                <div class="card-header text-center">
                                    <h3><strong class="card-title">Registro de Solicitudes</strong></h3>
                                </div>
                            </div>
                            <div class="login-form">
                                    <div class="form-group">
                                        <label class=" form-control-label">Usuario:</label>
                                        <div class="input-group">
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                    <asp:TextBox ID="Txt_Usuario" class="form-control alert-danger" runat="server" MaxLength="10"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="form-group">
                                            <label class=" form-control-label">Clave:</label>
                                            <div class="input-group">
                                                <div class="input-group">
                                                    <div class="input-group-addon"><i class="fa fa-asterisk"></i></div>
                                                        <asp:TextBox ID="Txt_Password" class="form-control alert-danger" runat="server" MaxLength="10" TextMode="Password"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <asp:Button ID="Btn_Aceptar" Width ="100%" runat="server" OnClick="SP_GeTUsuario" Text="Aceptar" class="btn btn-danger btn-sm"/>
                            </div>
                        </div>
                    </div>
                </div>      

    </form>

    <script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
    <script src="assets/js/main.js"></script>

</body>
</html>
