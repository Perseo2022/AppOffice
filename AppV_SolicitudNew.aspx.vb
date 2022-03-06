
Imports System.Data.SqlClient
Imports System
Imports System.IO
Imports System.Data
Imports System.Data.OleDb

Partial Class AppV_SolicitudNew
    Inherits System.Web.UI.Page
    'Variables de Permisos
    Public Vg_mod1 As Integer
    Public Vg_mod2 As Integer
    Public Vg_mod3 As Integer
    Public Vg_mod4 As Integer
    Public Vg_mod5 As Integer
    Public Vg_mod6 As Integer
    Public Vg_mod7 As Integer
    Public Vg_mod8 As Integer
    Public Vg_mod9 As Integer
    Public Vg_mod10 As Integer

    Public Vg_Fac1 As Integer
    Public Vg_Fac2 As Integer
    Public Vg_Fac3 As Integer
    Public Vg_Fac4 As Integer
    Public Vg_Fac5 As Integer
    Public Vg_Fac6 As Integer
    Public Vg_Fac7 As Integer
    Public Vg_Fac8 As Integer
    Public Vg_Fac9 As Integer
    Public Vg_Fac10 As Integer

    Public vg_Name As String
    Public vg_LastName As String
    Public vg_DateFlyExit As String

    '  Public Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
    Public Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

	    If Not Session("UsuAppV") <> "" Then
            Response.Write("<script>window.open('errorSesion.aspx',target='_self');<" & "/" & "script>")
        End If

        SP_GetPermiso()



        If Not Page.IsPostBack() Then
            Session("CodigoPasajero") = ""
            'Obtiene Tipo de Vuelo
            SP_GetTipoVuelo()
            'Obtienes Secretarias
            SP_GetSecretarias()
        End If
    End Sub

    Public Sub SP_GetPermiso()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        Try
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

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Public Sub SP_GetTipoVuelo()
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPGetTipoVuelo"
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

            DDL_TipoVuelo.DataTextField = "VuT_Descripcion"
            DDL_TipoVuelo.DataValueField = "VuT_Clave"
            DDL_TipoVuelo.DataSource = registro
            DDL_TipoVuelo.DataBind()
            DDL_TipoVuelo.Items.Insert(0, "Selecciona un Vuelo")

            registro.Close()
            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try
    End Sub

    Public Sub SP_GetSecretarias()
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPGetSecretariaByUser"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle


            Dim miParam As New SqlParameter("@UsuAppV", SqlDbType.VarChar)
            miParam.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam)
            coDetalle.Parameters("@UsuAppV").Value = Session("UsuAppV")

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

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try
    End Sub

    Public Sub SP_GetPasajero()
        Dim myConnection As SqlConnection
        Dim vl_bandera As Boolean = False


        Try
            If DDL_Secretarias.SelectedIndex <= 0 And Txt_Nombre.Text.Trim.Equals("") And Txt_ApPaterno.Text.Trim.Equals("") And Txt_ApMaterno.Text.Trim.Equals("") Then
                Alert("Captura un filtro de busqueda")
                Exit Sub
            End If

            Session("CodigoPasajero") = ""
            Lbl_Nombre.Text = ""

            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPGetPasajeroxFiltro"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            Dim dtTable As New DataTable

            'Parámetros si hubieran
            If Not Txt_Nombre.Text.Trim.Equals("") Then
                Dim miParam As New SqlParameter("@vp_Pas_Nombre", SqlDbType.VarChar)
                miParam.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam)
                coDetalle.Parameters("@vp_Pas_Nombre").Value = Txt_Nombre.Text.Trim
            End If

            If Not Txt_ApPaterno.Text.Trim.Equals("") Then
                Dim miParam1 As New SqlParameter("@vp_Pas_ApPaterno", SqlDbType.VarChar)
                miParam1.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam1)
                coDetalle.Parameters("@vp_Pas_ApPaterno").Value = Txt_ApPaterno.Text.Trim
            End If

            If Not Txt_ApMaterno.Text.Trim.Equals("") Then
                Dim miParam2 As New SqlParameter("@vp_Pas_ApMaterno", SqlDbType.VarChar)
                miParam2.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam2)
                coDetalle.Parameters("@vp_Pas_ApMaterno").Value = Txt_ApMaterno.Text.Trim
            End If

            Dim miParam4 As New SqlParameter("@vp_Opcion", SqlDbType.VarChar)
            miParam4.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam4)
            coDetalle.Parameters("@vp_Opcion").Value = 0

            If DDL_Secretarias.SelectedIndex > 0 Then
                Dim miParam3 As New SqlParameter("@vp_Sec_Clave", SqlDbType.Int)
                miParam3.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam3)
                coDetalle.Parameters("@vp_Sec_Clave").Value = CInt(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)
            End If

            daDetalle.Fill(dtTable)
            GV_Pasajero.DataSource = dtTable
            GV_Pasajero.DataBind()

            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub Alert(codigo As String)

        Response.Write("<script type=text/javascript>alert( ' Codigo: " & codigo & "');</script>")

    End Sub

    Protected Sub SP_SetSolicitudNew()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        If Not ValidaCampos() Then
            Exit Sub
        End If

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPSetSolicitudNew"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            Dim dtTable As New DataTable

            'Parámetros si hubieran
            Dim miParam As New SqlParameter("@Vp_Sol_Origen", SqlDbType.VarChar)
            miParam.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam)
            coDetalle.Parameters("@Vp_Sol_Origen").Value = Txt_Origen.Text.Trim

            Dim miParam1 As New SqlParameter("@Vp_Sol_Destino", SqlDbType.VarChar)
            miParam1.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam1)
            coDetalle.Parameters("@Vp_Sol_Destino").Value = Txt_Destino.Text.Trim

            Dim miParam2 As New SqlParameter("@Vp_Sol_FechaVueloSalida", SqlDbType.Char)
            miParam2.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam2)
            coDetalle.Parameters("@Vp_Sol_FechaVueloSalida").Value = Txt_DateFlyExit.Text.Trim

            Dim miParam3 As New SqlParameter("@Vp_Sol_HoraVueloSalida", SqlDbType.Char)
            miParam3.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam3)
            coDetalle.Parameters("@Vp_Sol_HoraVueloSalida").Value = Txt_HourFlyExit.Text.Trim

            Dim miParam4 As New SqlParameter("@Vp_Sol_FechaVueloRegreso", SqlDbType.Char)
            miParam4.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam4)
            coDetalle.Parameters("@Vp_Sol_FechaVueloRegreso").Value = Txt_DateFlyRet.Text.Trim

            Dim miParam5 As New SqlParameter("@Vp_Sol_HoraVueloRegreso", SqlDbType.Char)
            miParam5.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam5)
            coDetalle.Parameters("@Vp_Sol_HoraVueloRegreso").Value = Txt_HourFlyRet.Text.Trim

            Dim miParam6 As New SqlParameter("@Vp_Sol_DetalleVuelo", SqlDbType.Char)
            miParam6.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam6)
            coDetalle.Parameters("@Vp_Sol_DetalleVuelo").Value = Txt_DetailFly.Text.Trim

            Dim miParam7 As New SqlParameter("@Vp_Sol_ObjPartidista", SqlDbType.Char)
            miParam7.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam7)
            coDetalle.Parameters("@Vp_Sol_ObjPartidista").Value = Txt_ObPartido.Text.Trim

            Dim miParam8 As New SqlParameter("@Vp_Pas_Clave", SqlDbType.Int)
            miParam8.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam8)
            coDetalle.Parameters("@Vp_Pas_Clave").Value = CInt(Txt_IdPasajero.Text.Trim)


            Dim miParam9 As New SqlParameter("@Vp_Ret_Clave", SqlDbType.Int)
            miParam9.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam9)
            coDetalle.Parameters("@Vp_Ret_Clave").Value = 1

            If DDL_TipoVuelo.SelectedIndex > 0 Then
                Dim miParam10 As New SqlParameter("@Vp_VuT_Clave", SqlDbType.Int)
                miParam10.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam10)
                coDetalle.Parameters("@Vp_VuT_Clave").Value = CInt(DDL_TipoVuelo.Items(DDL_TipoVuelo.SelectedIndex).Value)
            End If

            'Solicitud por Cotizar
            Dim miParam11 As New SqlParameter("@Vp_Sot_Clave", SqlDbType.Int)
            miParam11.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam11)
            coDetalle.Parameters("@Vp_Sot_Clave").Value = 1

            If DDL_Secretarias.SelectedIndex > 0 Then
                Dim miParam12 As New SqlParameter("@vp_Sec_Clave", SqlDbType.Int)
                miParam12.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam12)
                coDetalle.Parameters("@vp_Sec_Clave").Value = CInt(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)
            End If

            'Ejecutar el Store Procedure

            Dim registro As SqlDataReader = coDetalle.ExecuteReader

            If registro.Read Then
                vl_Respuesta = registro(0).ToString
                Session("CodigoRespuesta") = vl_Respuesta
                Alert(vl_Respuesta)
                'CodigoRespuesta.Value = vl_Respuesta
                Session("CodigoPasajero") = ""
                Response.Write("<script>window.open('AppV_SolicitudNew.aspx',target='_self');<" & "/" & "script>")
            Else
                Alert("Ocurrio un Error. Favor de contactar al Administrador del Sistema.")
            End If

            registro.Close()
            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Public Sub SP_SetPasajero()

        Response.Write("<script>window.open('AppV_PasajeroNew.aspx',target='_self');<" & "/" & "script>")

    End Sub

    Protected Sub GV_Pasajero_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow = GV_Pasajero.SelectedRow
        Try
            Txt_IdPasajero.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Pas_Clave"))
            Lbl_Nombre.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Pas_Nombre")) & " " &
           Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Pas_ApPaterno")) & " " &
           Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Pas_ApMaterno"))
            Session("CodigoPasajero") = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Pas_Nombre"))
            DDL_TipoVuelo.SelectedIndex = 0

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try
    End Sub

    Protected Sub GV_Pasajero_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        'If (e.Row.RowType = DataControlRowType.Header) Then
        '    e.Row.Cells(5).Visible = False
        'End If
        'If (e.Row.RowType = DataControlRowType.DataRow) Then
        '    e.Row.Cells(5).Visible = False
        'End If
    End Sub

    Function ValidaCampos() As Boolean
        Dim vl_errordescripcion As String = ""
        Dim vl_campo As String = ""

        ValidaCampos = True
        Try
            If Txt_Origen.Text.Trim.Equals("") Then
                ValidaCampos = False
                vl_campo = "Origen"
            End If
            If Txt_Destino.Text.Trim.Equals("") Then
                ValidaCampos = False
                vl_campo = "Destino"
            End If
            If Txt_DateFlyExit.Text.Trim.Equals("") Then
                ValidaCampos = False
                vl_campo = "Fecha Salida"
            End If
            If Txt_HourFlyExit.Text.Trim.Equals("") Then
                ValidaCampos = False
                vl_campo = "Hora Salida"
            End If
            If DDL_TipoVuelo.SelectedIndex <= 0 Then
                ValidaCampos = False
                vl_campo = "Tipo de Vuelo"
            End If
            If DDL_TipoVuelo.SelectedIndex = 2 Then
                If Txt_DateFlyRet.Text.Trim.Equals("") Then
                    ValidaCampos = False
                    vl_campo = "Fechas Regreso"
                End If
                If Txt_HourFlyRet.Text.Trim.Equals("") Then
                    ValidaCampos = False
                    vl_campo = "Hora Regreso"
                End If
            End If
            If Txt_IdPasajero.Text.Trim.Equals("") Then
                ValidaCampos = False
                vl_campo = "Pasajero"
            End If
            If ValidaCampos = False Then
                Alert("Campo: " & vl_campo & " No Informado")
                Exit Function
            End If
            ValidaCampos = True

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Function

End Class
