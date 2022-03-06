<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestAlert.aspx.vb" Inherits="TestAlert" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript">
        function myFuncionAlerta() {
            alert("Alerta JavaScript")
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="miBoton" runat="server" OnClick="alert"
                    Text="Llama JavaScript" />
        </div>
    </form>
</body>
</html>
