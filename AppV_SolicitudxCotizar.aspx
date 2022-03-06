﻿<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>

<script runat="server">
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

    Public vg_Name As String
    Public vg_LastName As String
    Public vg_FileCot As String

    Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If Not Session("UsuAppV") <> "" Then
            Response.Write("<script>window.open('portal.aspx',target='_self');<" & "/" & "script>")
        End If
        SP_GetPermiso()
        'Dim dsColumnas As New DataSet
        If Not Page.IsPostBack() Then
            'Obtiene Tipo de Requerimiento
            'SP_GetReq()
            'Obtiene Tipo de Vuelo
            SP_GetTipoVuelo()
            'Obtienes Secretarias
            SP_GetSecretarias()
            'Obtiene Arerolinea
            SP_GetAerolinea()
            'Obtiene Agencia
            SP_GetAgencia()
            SP_GetSolicitudxFiltro()
            'Clean Campos
            'CleanFields()
            'If Not Session("vp_UsuCve") <> "" Then
            '    MsgBox("No puedes estar aqui", MsgBoxStyle.Exclamation, "iDocumental")
            'End If
            'If Request.QueryString("vq_usucve") <> "" Then
            '    Buscar(Trim(Request.QueryString("vq_usucve")))
            'End If
        Else
            'Session("vs_row") = New GridViewRow
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
                        If Vg_Fac2 = 1 Then
                            Btn_Aceptar.Enabled = False
                        End If

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

    Sub SP_GetAgencia()
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPGetAgencia"
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

            DDL_Agencia.DataTextField = "Age_Descripcion"
            DDL_Agencia.DataValueField = "Age_Clave"
            DDL_Agencia.DataSource = registro
            DDL_Agencia.DataBind()
            DDL_Agencia.Items.Insert(0, "Selecciona una Agencia")

            registro.Close()
            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub SP_GetTipoVuelo()
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

    Sub SP_GetSecretarias()
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

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

    Function ValidaCampos() As Boolean
        ValidaCampos = False
        Try
            If DDL_Agencia.SelectedIndex <= 0 Then
                Response.Write("<script>javascript: alert('Seleccione una Agencia');<" & "/" & "script>")
                Exit Function
            End If
            If DDL_Aerolinea.SelectedIndex <= 0 Then
                Response.Write("<script>javascript: alert('Seleccione una Aerolinea');<" & "/" & "script>")
                Exit Function
            End If
            If Lbl_FileName.Text.Equals("") Then
                Response.Write("<script>javascript: alert('Seleccione una Cotizacion');<" & "/" & "script>")
                Exit Function
            End If
            If Txt_Costo.Text.Equals("") Then
                Response.Write("<script>javascript: alert('Escriba un Costo');<" & "/" & "script>")
                Exit Function
            End If
            If Txt_Comentarios.Text.Equals("") Then
                Response.Write("<script>javascript: alert('Escriba Comentarios');<" & "/" & "script>")
                Exit Function
            End If
            ValidaCampos = True

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Function

    Sub SP_SetSolicitudxCotizar()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        Try
            If ValidaCampos() Then

                myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
                myConnection.Open()

                'Definir un SQLCommand, El nombre del Store Procedure en CommandText
                'El CommandType = StoreProcedure y la conexion
                Dim coDetalle As New SqlCommand
                coDetalle.CommandText = "AppV_SPSetSolicitudxCotizar"
                coDetalle.CommandType = CommandType.StoredProcedure
                coDetalle.Connection = myConnection  'Previamente definida

                'El Adaptador y su SelectCommand
                Dim daDetalle As New SqlDataAdapter
                daDetalle.SelectCommand = coDetalle

                Dim dtTable As New DataTable

                'Parámetros si hubieran
                Dim miParam As New SqlParameter("@Sol_ClaveCon", SqlDbType.Int)
                miParam.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam)
                coDetalle.Parameters("@Sol_ClaveCon").Value = CInt(Txt_SolClaveCon.Text.Trim)

                If DDL_Agencia.SelectedIndex > 0 Then
                    Dim miParam1 As New SqlParameter("@Vp_Age_Clave", SqlDbType.Int)
                    miParam1.Direction = ParameterDirection.Input
                    coDetalle.Parameters.Add(miParam1)
                    coDetalle.Parameters("@Vp_Age_Clave").Value = CInt(DDL_Agencia.Items(DDL_Agencia.SelectedIndex).Value)
                End If

                If DDL_Aerolinea.SelectedIndex > 0 Then
                    Dim miParam2 As New SqlParameter("@Vp_Aer_Clave", SqlDbType.Int)
                    miParam2.Direction = ParameterDirection.Input
                    coDetalle.Parameters.Add(miParam2)
                    coDetalle.Parameters("@Vp_Aer_Clave").Value = CInt(DDL_Aerolinea.Items(DDL_Aerolinea.SelectedIndex).Value)
                End If

                Dim miParam3 As New SqlParameter("@Sol_Archivo", SqlDbType.VarChar)
                miParam3.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam3)
                coDetalle.Parameters("@Sol_Archivo").Value = Lbl_FileName.Text.Trim

                Dim miParam4 As New SqlParameter("@Sol_Costo", SqlDbType.Float)
                miParam4.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam4)
                coDetalle.Parameters("@Sol_Costo").Value = CDbl(Txt_Costo.Text.Trim)

                Dim miParam5 As New SqlParameter("@Sol_Comentarios", SqlDbType.Text)
                miParam5.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam5)
                coDetalle.Parameters("@Sol_Comentarios").Value = Txt_Comentarios.Text.Trim

                Dim miParam6 As New SqlParameter("@Sot_Clave", SqlDbType.Char)
                miParam6.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam6)
                coDetalle.Parameters("@Sot_Clave").Value = 2 ' Por Validar

                'Ejecutar el Store Procedure
                Dim registro As SqlDataReader = coDetalle.ExecuteReader

                If registro.Read Then
                    vl_Respuesta = registro(0).ToString
                    Alert("Solicitud por Cotizar Asignada")
                    Response.Write("<script>window.open('AppV_SolicitudxCotizar.aspx',target='_self');<" & "/" & "script>")
                Else
                    Alert("Ocurrio un Error. Favor de contactar al Administrador del Sistema.")
                End If

                registro.Close()
                myConnection.Close()

            End If

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub SP_GetSolicitudxFiltro()
        Dim myConnection As SqlConnection

        CleanFields()
        Try

            '  If DDL_Secretarias.SelectedIndex <= 0 And Txt_Nombre.Text.Trim.Equals("") And
            ' Txt_ApPaterno.Text.Trim.Equals("") And Txt_ApMaterno.Text.Trim.Equals("") And
            'Txt_Clave.Text.Trim.Equals("") Then
            'Alert("Captura un filtro de busqueda")
            'Exit Sub
            'End If


            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPGetSolicitudxFiltro"
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

            If Not Txt_Clave.Text.Trim.Equals("") Then
                Dim miParam3 As New SqlParameter("@Sol_Clave", SqlDbType.VarChar)
                miParam3.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam3)
                coDetalle.Parameters("@Sol_Clave").Value = Txt_Clave.Text.Trim
            End If

            Dim miParam5 As New SqlParameter("@Sot_Clave", SqlDbType.Int)
            miParam5.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam5)
            coDetalle.Parameters("@Sot_Clave").Value = 1 ' Por Cotizar

            If DDL_Secretarias.SelectedIndex > 0 Then
                Dim miParam4 As New SqlParameter("@vp_Sec_Clave", SqlDbType.Int)
                miParam4.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam4)
                coDetalle.Parameters("@vp_Sec_Clave").Value = CInt(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)
            End If


            Dim miParam6 As New SqlParameter("@UsuAppV", SqlDbType.VarChar)
            miParam6.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam6)
            coDetalle.Parameters("@UsuAppV").Value = Session("UsuAppV")

            'MsgBox(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)

            If Not Session("vs_Mes").Equals("") And Not Session("vs_Mes").Equals("-1") And Not Session("vs_Mes").Equals("0") Then
                Dim miParam7 As New SqlParameter("@id_mes", SqlDbType.Int)
                miParam7.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam7)
                coDetalle.Parameters("@id_mes").Value = Session("vs_Mes")
            End If
            daDetalle.Fill(dtTable)
            GV_Pasajero.DataSource = dtTable
            GV_Pasajero.DataBind()
            Lbl_Conteo.Text = GV_Pasajero.Rows.Count()

            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub GV_Pasajero_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Try
            If (e.Row.RowType = DataControlRowType.Header) Then
                e.Row.Cells(1).Visible = False
                e.Row.Cells(4).Visible = False
                e.Row.Cells(5).Visible = False
                e.Row.Cells(6).Visible = False
                e.Row.Cells(7).Visible = False
                e.Row.Cells(8).Visible = False
                e.Row.Cells(9).Visible = False
                e.Row.Cells(10).Visible = False
                e.Row.Cells(11).Visible = False
                e.Row.Cells(12).Visible = False
                e.Row.Cells(13).Visible = False
                e.Row.Cells(17).Visible = False
                e.Row.Cells(19).Visible = False
                e.Row.Cells(20).Visible = False
                e.Row.Cells(21).Visible = False
                e.Row.Cells(22).Visible = False
                e.Row.Cells(23).Visible = False
                e.Row.Cells(24).Visible = False
                'e.Row.Cells(24).Visible = False
                'e.Row.Cells(25).Visible = False
                'e.Row.Cells(26).Visible = False
                'e.Row.Cells(27).Visible = False
                'e.Row.Cells(28).Visible = False
                'e.Row.Cells(29).Visible = False
                'e.Row.Cells(30).Visible = False
                'e.Row.Cells(31).Visible = False
                'e.Row.Cells(32).Visible = False
                e.Row.Cells(2).Font.Size = 10
                e.Row.Cells(3).Font.Size = 10
                e.Row.Cells(14).Font.Size = 10
                e.Row.Cells(15).Font.Size = 10
                e.Row.Cells(16).Font.Size = 10
                e.Row.Cells(18).Font.Size = 10
                e.Row.Cells(25).Font.Size = 10
                e.Row.Cells(2).Text = "CLAVE"
                e.Row.Cells(3).Text = "ORIGEN"
                e.Row.Cells(14).Text = "NOMBRE"
                e.Row.Cells(15).Text = "PATERNO"
                e.Row.Cells(16).Text = "MATERNO"
                e.Row.Cells(18).Text = "SECRETARIA"
                e.Row.Cells(25).Text = "FECHASOL"
            End If
            If (e.Row.RowType = DataControlRowType.DataRow) Then
                e.Row.Cells(1).Visible = False
                'e.Row.Cells(3).Visible = False
                e.Row.Cells(4).Visible = False
                e.Row.Cells(5).Visible = False
                e.Row.Cells(6).Visible = False
                e.Row.Cells(7).Visible = False
                e.Row.Cells(8).Visible = False
                e.Row.Cells(9).Visible = False
                e.Row.Cells(10).Visible = False
                e.Row.Cells(11).Visible = False
                e.Row.Cells(12).Visible = False
                e.Row.Cells(13).Visible = False
                e.Row.Cells(17).Visible = False
                e.Row.Cells(19).Visible = False
                e.Row.Cells(20).Visible = False
                e.Row.Cells(21).Visible = False
                e.Row.Cells(22).Visible = False
                e.Row.Cells(23).Visible = False
                e.Row.Cells(24).Visible = False
                'e.Row.Cells(25).Visible = False
                'e.Row.Cells(26).Visible = False
                'e.Row.Cells(27).Visible = False
                'e.Row.Cells(28).Visible = False
                'e.Row.Cells(29).Visible = False
                'e.Row.Cells(30).Visible = False
                'e.Row.Cells(31).Visible = False
                'e.Row.Cells(32).Visible = False
                e.Row.Cells(2).Font.Size = 10
                e.Row.Cells(3).Font.Size = 10
                e.Row.Cells(14).Font.Size = 10
                e.Row.Cells(15).Font.Size = 10
                e.Row.Cells(16).Font.Size = 10
                e.Row.Cells(18).Font.Size = 10
                e.Row.Cells(25).Font.Size = 10
            End If

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub GV_Pasajero_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow
        Try
            row = GV_Pasajero.SelectedRow

            ''SELECT [Sol_ClaveCon],[Sol_Clave],[Sol_Origen],[Sol_Destino],[Sol_FechaVueloSalida],[Sol_HoraVueloSalida]
            '					,[Sol_FechaVueloRegreso],[Sol_HoraVueloRegreso],[Sol_Reservacion],[Aer_Clave],[Age_Clave],[Sol_DetalleVuelo]
            '					,[Sol_ObjPartidista],[dbo].[AppV_Pasajero].Pas_Nombre,[dbo].[AppV_Pasajero].Pas_ApPaterno
            '					,[dbo].[AppV_Pasajero].Pas_ApMaterno,[dbo].[AppV_Secretarias].Sec_Clave,[dbo].[AppV_Secretarias].Sec_Descripcion
            '					,[dbo].[AppV_RequisicionTipo].ReT_Clave,[dbo].[AppV_RequisicionTipo].ReT_Descripcion,[dbo].[AppV_VueloTipo].[VuT_Clave]
            '					,[dbo].[AppV_VueloTipo].VuT_Descripcion,[dbo].[AppV_SolicitudTipo].SoT_Clave,[dbo].[AppV_SolicitudTipo].SoT_Descripcion

            'Session("vs_FileCot") = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Clave"))
            Txt_Origen.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Origen"))
            'Txt_Origen.Text = Me.GV_Pasajero.SelectedRow.Cells(2).Text
            Txt_Destino.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Destino"))
            'Txt_Destino.Text = Me.GV_Pasajero.SelectedRow.Cells(3).Text
            Txt_DateFlyExit.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_FechaVueloSalida"))
            Txt_HourFlyExit.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_HoraVueloSalida"))
            Txt_DateFlyRet.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_FechaVueloRegreso"))
            Txt_HourFlyRet.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_HoraVueloRegreso"))
            Txt_DetailFly.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_DetalleVuelo"))
            Txt_ObPartido.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_ObjPartidista"))
            Txt_SolClaveCon.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_ClaveCon"))
            Txt_HourFlyExit.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_HoraVueloSalida"))
            Txt_HourFlyRet.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_HoraVueloRegreso"))



            Dim TipoReq As Integer = Convert.ToInt16(GV_Pasajero.DataKeys(row.RowIndex).Values("ReT_Clave"))
            Dim TipoVue As Integer = Convert.ToInt16(GV_Pasajero.DataKeys(row.RowIndex).Values("VuT_Clave"))

            Lbl_Nombre.Text = Me.GV_Pasajero.SelectedRow.Cells(14).Text & " " &
                                Me.GV_Pasajero.SelectedRow.Cells(15).Text & " " &
                                Me.GV_Pasajero.SelectedRow.Cells(16).Text

            'DDL_Req.SelectedValue = TipoReq
            DDL_TipoVuelo.SelectedValue = TipoVue

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub CleanFields()
        Try
            Txt_Origen.Text = ""
            Txt_Destino.Text = ""
            Txt_DateFlyExit.Text = ""
            Txt_HourFlyExit.Text = ""
            Txt_DateFlyRet.Text = ""
            Txt_HourFlyRet.Text = ""
            Txt_DetailFly.Text = ""
            Txt_ObPartido.Text = ""
            'DDL_Req.SelectedIndex = 0
            DDL_TipoVuelo.SelectedIndex = 0
            'Txt_Origen.Enabled = False
            'Txt_Destino.Enabled = False
            'Txt_DateFlyExit.Enabled = False
            'Txt_HourFlyExit.Enabled = False
            'Txt_DateFlyRet.Enabled = False
            'Txt_HourFlyRet.Enabled = False

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub SP_GetAerolinea()
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPGetAerolinea"
            coDetalle.CommandType = CommandType.StoredProcedure
            coDetalle.Connection = myConnection  'Previamente definida

            'El Adaptador y su SelectCommand
            Dim daDetalle As New SqlDataAdapter
            daDetalle.SelectCommand = coDetalle

            'Ejecutar el Store Procedure
            Dim registro As SqlDataReader = coDetalle.ExecuteReader

            DDL_Aerolinea.DataTextField = "Aer_Descripcion"
            DDL_Aerolinea.DataValueField = "Aer_Clave"
            DDL_Aerolinea.DataSource = registro
            DDL_Aerolinea.DataBind()
            DDL_Aerolinea.Items.Insert(0, "Selecciona una Aerolinea")

            registro.Close()
            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub UploadBtn_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim savePath As String = Server.MapPath("~/cotizacion/")

        Try

            If UploadButton.Text = "Agregar Archivo" Then
                ' Before attempting to save the file, verify
                ' that the FileUpload control contains a file.
                If (FileUpload1.HasFile) Then

                    ' Get the name of the file to upload.
                    Dim fileName As String = Server.HtmlEncode(FileUpload1.FileName)

                    ' Get the extension of the uploaded file.
                    Dim extension As String = System.IO.Path.GetExtension(fileName)

                    ' Allow only files with .doc or .xls extensions
                    ' to be uploaded.
                    extension = extension.ToLower
                    If (extension = "pdf") Or (extension = ".pdf") _
                Or (extension = "jpg") Or (extension = ".jpg") Or (extension = "jpeg") Or (extension = ".jpeg") _
                Or (extension = "png") Or (extension = ".png") Or (extension = "gif") Or (extension = ".gif") _
                Or (extension = "xls") Or (extension = ".xls") Or (extension = "xlsx") Or (extension = ".xlsx") Then

                        ' Append the name of the file to upload to the path.
                        savePath += Txt_SolClaveCon.Text + "_" + fileName

                        ' Call the SaveAs method to save the 
                        ' uploaded file to the specified path.
                        ' This example does not perform all
                        ' the necessary error checking.               
                        ' If a file with the same name
                        ' already exists in the specified path,  
                        ' the uploaded file overwrites it.
                        FileUpload1.SaveAs(savePath)

                        ' Notify the user that their file was successfully uploaded.
                        Lbl_FileName.Text = Txt_SolClaveCon.Text + "_" + fileName 'FileUpload1.FileName
                        UploadStatusLabel.BackColor = System.Drawing.Color.Green
                        UploadStatusLabel.Text = "Archivo Cargado."
                        UploadButton.Text = "Borrar Archivo"
                        FileUpload1.Visible = False
                    Else
                        ' Notify the user why their file was not uploaded.
                        UploadStatusLabel.BackColor = System.Drawing.Color.Red
                        UploadStatusLabel.Text = "Archivo no cargado."
                        Lbl_FileName.Text = ""
                    End If

                Else
                    ' Notify the user that a file was not uploaded.
                    UploadStatusLabel.BackColor = System.Drawing.Color.Red
                    UploadStatusLabel.Text = "Archivo No Seleccionado."
                    Lbl_FileName.Text = ""
                End If
            ElseIf UploadButton.Text = "Borrar Archivo" Then
                If File.Exists(savePath & Lbl_FileName.Text) Then
                    File.Delete(savePath & Lbl_FileName.Text)
                End If
                FileUpload1.Visible = True
                UploadStatusLabel.Text = ""
                UploadStatusLabel.BackColor = System.Drawing.Color.White
                UploadButton.Text = "Agregar Archivo"
                Lbl_FileName.Text = ""
            End If

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub Alert(codigo As String)

        Response.Write("<script>window.alert('" & codigo & "');<" & "/" & "script>")

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

        #GV_Pasajero tr{
            cursor:pointer;
        }

        #Mensaje {
    font-size: 18px;
    font-family: "Open Sans", sans-serif;
    font-weight: 400;
    line-height: 24px;
    color: #f54d18;
        }
        
    </style>
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
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1" NavigateUrl ="AppV_SolicitudNew.aspx" runat="server">Nueva</asp:HyperLink></li>
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
                        <strong class="card-title">Solicitudes / Por Cotizar</strong><asp:Label ID="Lbl_Conteo" class=" form-control-label" runat="server"></asp:Label>
                    </div>
                    <div class="card-body">
                        
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Pasajero</strong>
                                </div>
                                <div class="card-body card-block" disable>
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
                                                    <div class="form-group col-md-8">
                                                        <div class="input-group">
                                                            <label class=" form-control-label">Secretaria</label>
                                                            <div class="input-group">
                                                                <asp:DropDownList ID="DDL_Secretarias" class="form-control" runat="server"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <div class="input-group">
                                                            <label class=" form-control-label">Clave</label>
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-key"></i></div>
                                                                    <asp:TextBox ID="Txt_Clave" class="form-control" runat="server" MaxLength="6"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <div class="input-group">
                                                            <label class=" form-control-label">Buscar</label>
                                                            <div class="input-group">
                                                                <!-- <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#scrollmodal"><i class="fa fa-search"></i>&nbsp; Buscar</button> -->
                                                                <asp:Button ID="Btn_Buscar" runat="server" Text="Ok" class="btn btn-success" onclick="SP_GetSolicitudxFiltro" />
                                                                <asp:TextBox ID="Txt_SolClaveCon" runat="server" Visible="False"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <asp:GridView ID="GV_Pasajero" runat="server" Width="100%" OnRowDataBound="GV_Pasajero_RowDataBound"
                                                            CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GV_Pasajero_SelectedIndexChanged"
                                                            DataKeyNames="Sol_ClaveCon,Sol_Origen,Sol_Destino,Sol_FechaVueloSalida,Sol_HoraVueloSalida,Sol_FechaVueloRegreso,Sol_HoraVueloRegreso,
                                                            Sol_DetalleVuelo,Sol_ObjPartidista,ReT_Clave,VuT_Clave"
                                                             ShowHeaderWhenEmpty="True" EmptyDataText="No se encontraron registros">
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

                                                            <Columns>
                                                                <asp:CommandField ShowSelectButton="True" SelectText="Ok" ButtonType="Image" SelectImageUrl="~/images/Edit.jpg"></asp:CommandField>

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

                        <!-- Solicitud -->
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud: </strong><asp:Label ID="Lbl_Nombre" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Origen</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-sign-in"></i></div>
                                                                <asp:TextBox ID="Txt_Origen"  class="form-control" runat="server" MaxLength="50" ReadOnly></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Destino</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-sign-out"></i></div>
                                                            <asp:TextBox ID="Txt_Destino"  class="form-control" runat="server" MaxLength="50" ReadOnly></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Tipo de Vuelo</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-plane"></i></div>
                                                            <asp:DropDownList ID="DDL_TipoVuelo" class="form-control" runat="server" ReadOnly ></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Fecha Vuelo Salida</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_DateFlyExit"  type="date"    class="form-control" runat="server"  MaxLength="10" ReadOnly></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Horario Vuelo Salida</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            <asp:TextBox ID="Txt_HourFlyExit" type="text"  runat="server"  MaxLength="5" class="form-control" ReadOnly></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Fecha Vuelo Regreso</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            <asp:TextBox ID="Txt_DateFlyRet" type="date"  class="form-control"  MaxLength="10" runat="server" ReadOnly ></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Horario Vuelo Regreso</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            <asp:TextBox ID="Txt_HourFlyRet" type="text"  runat="server"  MaxLength="5" class="form-control" ReadOnly></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <label class=" form-control-label">Detalle de Vuelo</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-th-large"></i></div>
                                                            <asp:TextBox ID="Txt_DetailFly"   runat="server" Rows="4" class="form-control" TextMode="MultiLine" ReadOnly></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <label class=" form-control-label">Objeto Partidista</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-th-large"></i></div>
                                                            <asp:TextBox ID="Txt_ObPartido"   runat="server" Rows="4" class="form-control" TextMode="MultiLine" ReadOnly></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                    <!-- /.table-stats -->
                                </div>
                            </div>
                        <!-- /Solicitud -->
                        </div>

                        <!-- Cotizacion -->
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Cotizacion</strong>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Proveedor</label>
                                                        <div class="input-group">
                                                            <asp:DropDownList ID="DDL_Agencia" class="form-control" runat="server"></asp:DropDownList>
                                                        </div>
                                                    </div>


                                                    <div class="form-group col-md-6">
                                                        <label class=" form-control-label">Aerolinea</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <asp:DropDownList ID="DDL_Aerolinea" class="form-control" runat="server"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-6">
                                                        <div class="input-group">
                                                            <asp:FileUpload id="FileUpload1" runat="server"></asp:FileUpload>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-3">
                                                        <div class="input-group">
                                                            <asp:Button id="UploadButton" Text="Agregar Archivo" OnClick="UploadBtn_Click" runat="server"></asp:Button>   
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-3">
                                                        <asp:Label ID="Label1" Text="(pdf, xls, xlsx, jpeg, jpg, png, gif)" Font-Size="Smaller"  runat="server"></asp:Label>
                                                        <asp:Label ID="UploadStatusLabel" class=" form-control-label" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <label class=" form-control-label">Comentarios</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-th-large"></i></div>
                                                            <asp:TextBox ID="Txt_Comentarios" runat="server" Rows="4" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-3">
                                                        <label class=" form-control-label">Costo</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-dollar (alias)"></i></div>
                                                            <asp:TextBox ID="Txt_Costo" class="form-control" runat="server" MaxLength="50"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Aceptar</label>
                                                        <div class="input-group">
                                                            <asp:Button ID="Btn_Aceptar" runat="server" OnClick="SP_SetSolicitudxCotizar" class="btn btn-success" Text="Ok" />
                                                        </div>
                                                    </div>

                                                     <div class="form-group col-md-5">
                                                        <div class="input-group">
                                                            <p id="Mensaje"></p>
                                                        </div>
                                                    </div>
                                                </div>
                                    <!-- /.table-stats -->
                                </div>
                            </div>
                        <!-- /Cotizacion -->
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
                                        <asp:Label ID="Lbl_FileName" Visible="false"  runat="server"></asp:Label>
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

            </form>

        </div>
        <!-- /.content -->
        <div class="clearfix"></div>
        <!-- Footer -->
            <footer class="site-footer">
                <div class="footer-inner bg-white">
                    <div class="row">
                        <div class="col-sm-4 text-left">
                            <!--Copyright &copy; 2018 Empresa-->
                        </div>
                        <div class="col-sm-4 text-center">
                            <i class="fa fa-envelope"></i>
                            <asp:HyperLink ID="HyperLink16" NavigateUrl ="https://discord.gg/tdeNj3Bneh" runat="server">Contactanos</asp:HyperLink>
                        </div>
                        <div class="col-sm-4 text-right">
                            <!--Designed by <a href="smart.cen-pri.mx">Empresa</a>-->
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
     <script src="js/Vuelos.js"></script>
     <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script type="text/javascript">
        $(document).ready(function () {
          //  Vuelos();
            //getMoticoCancel
            //Mensaje

            $("#DDL_Agencia").change(function () {
                $.ajax({
                    type: "POST",
                    url: "VuelosService.aspx/getPresupuesto",
                    data: '{ageClave: "' + $(this).val() + '"  }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        if (r.d != '') {
                            Swal.fire(
                                'Alerta',
                                r.d,
                                'warning'
                            );
                        }

                        
                    }
                });
               
            });

            $('#GV_Pasajero').on('click', 'tr td', function (evt) {
                var codigo = $(this).parents("tr").find("td").eq(1).text();
                descarga(codigo);
                if (typeof codigo != undefined ) {
                    $.ajax({
                        type: "POST",
                        url: "VuelosService.aspx/getMoticoCancel",
                        data: '{codeEvento: "' + codigo + '"  }',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            $("#Mensaje").text(r.d);
                        }
                    });
                }
               
            });
    
        });
        
    </script>
</body>
</html>
