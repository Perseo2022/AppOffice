
Partial Class TestAlert
    Inherits System.Web.UI.Page
    Protected Sub alert()
        ScriptManager.RegisterStartupScript(Me, Me.Page.GetType,
                                            "myFuncionAlerta", "myFuncionAlerta();", True)
    End Sub

End Class
