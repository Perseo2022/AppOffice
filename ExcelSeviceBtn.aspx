<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
    <script src="js/Vuelos.js"></script>
    <script type="text/javascript">
        //window.onload = function () {
        $(window).load(function () {
            descarga('<%=Session("vs_Codigo")%>');
            //window.close();
            $(".loader").fadeOut("slow");
        });
    </script>

</head>
<body>

</body>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                success: function (r) {
                    window.close();
                }
            });
           
    </script>
</html>
