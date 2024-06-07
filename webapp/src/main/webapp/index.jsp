Index.html

<html>
    <head><title>JSP With JDBC</title></head>
    <body>
        <h1><a href="Register.html" >New User Register Here</a></h1>
  <h1><a href="Login.html" >Click Here to Login</a></h1>  
    </body>
</html>

Register.html

<html><head><title>New User Registration Page</title></head>
    <body>
        <form action="Register.jsp" >
            <h1> New User Registration Page</h1>
            Enter User Name <input type="text" name="txtName" ><br>
            Enter Password <input type="password" name="txtPass1" ><br>
            Re-Enter Password<input type="password" name="txtPass2" ><br>
            Enter Email<input type="text" name="txtEmail" ><br>
            Enter Country Name <input type="text" name="txtCon" ><br>
            <input type="reset" ><input type="submit" value="REGISTER" >
        </form>
    </body>
</html>


Register.jsp

<%@page contentType="text/html" import="java.sql.*"%>
<html><body>
        <h1>Registration JSP Page</h1>
    <%
        String uname=request.getParameter("txtName");
        String pass1 = request.getParameter("txtPass1");
        String pass2 = request.getParameter("txtPass2");
        String email = request.getParameter("txtEmail");
        String ctry = request.getParameter("txtCon");
  if(pass1.equals(pass2)){
        try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/logindb","root","tiger");
    PreparedStatement stmt = con.prepareStatement("insert into user values (?,?,?,?)");
    stmt.setString(1, uname);    stmt.setString(2, pass1);
    stmt.setString(3, email);    stmt.setString(4, ctry);
    int row = stmt.executeUpdate();
    if(row==1) { out.println("Registration Successful"); }
    else {    
        out.println("Registration FFFFFAAAIIILLLL !!!!");
        %>
            <jsp:include page="Register.html" ></jsp:include>
        <%
    
        }
    }catch(Exception e){out.println(e);}
  }
  else 
  {
  out.println("<h1>Password Mismatch</h1>");
  %>
  <jsp:include page="Register.html" ></jsp:include>
<%  }
    %>
    </body>
</html>

Login.html

<html>
    <body>
        <h1>Login Page</h1>
        <form action="Login.jsp" >          
            Enter User Name <input type="text" name="txtName" ><br>
            Enter Password <input type="password" name="txtPass" ><br>     
            <input type="reset" ><input type="submit" value="~~~LOGIN~~" >
        </form>
    </body>
</html>

Login.jsp
<%@page contentType="text/html" import="java.sql.*"%>
<html><body>
        <h1>Registration JSP Page</h1>
    <%
        String uname=request.getParameter("txtName");
        String pass = request.getParameter("txtPass");
       

        try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/logindb","root","tiger");
    PreparedStatement stmt = con.prepareStatement("select password from user where username=?");
    stmt.setString(1, uname);  
    ResultSet rs = stmt.executeQuery();
    if(rs.next()){
        if(pass.equals(rs.getString(1)))
        {
            out.println("<h1>~~~ LOGIN SUCCESSFULLL ~~~ </h1>");
        }
        }
    else{
    out.println("<h1>User Name not exist !!!!!</h1>");
    %>
    <jsp:include page="Register.html" ></jsp:include>
        <%
    }
        }catch(Exception e){out.println(e);}
   %>
    </body>
</html>
