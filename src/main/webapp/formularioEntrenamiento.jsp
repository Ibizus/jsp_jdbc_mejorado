<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Formulario entrenamiento</title>
</head>
<body>
<h2>Introduzca los datos del nuevo entrenamiento:</h2>
<form method="post" action="grabaEntrenamiento.jsp">

    Tipo de entrenamiento <select name="tipo">
                                <option value="fisico">Físico</option>
                                <option value="tecnico">Técnico</option>
                            </select></br>
    Ubicación <input type="text" name="ubicacion"/></br>
    Fecha <input type="date" name="fecha"/></br>
    <input type="submit" value="Guardar">
</form>

<%
    String error = (String)session.getAttribute("error");

    if(error != null){
%>

<span style="color:red"><%= error%></span>

<%
        session.removeAttribute("error");
    }
%>

</body>
</html>