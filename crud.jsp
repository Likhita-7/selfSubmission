<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,com.crud.Emp,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="GET">
    id : <input type="text" id="id" name="id"/><br><br>
    Name : <input type="text" id="name" name="name"/><br><br>
    department : <input type="text" id="dept" name="dept"/><br><br>
    Salary : <input type="text" id="sal" name="sal"/><br><br>
    Mode:<select id="selectt">
	<option>Edit</option>
	<option>Add</option>
	<option>Delete</option>
	</select> <br><br>
    <button type="submit" id="first" name="mode" value="first">First</button>
    <button type="submit" name="mode" value="last">Last</button>
    <button type="submit" name="mode" value="previous">previous</button>
    <button type="submit" name="mode" value="next">next</button><br><br>
    <button type="submit" name="mode" value="edit">edit</button>
    <button type="submit" name="mode" value="add">Add</button>
    <button type="submit" name="mode" value="delete">Delete</button>
    <button type="submit" name="mode" value="save">save</button><br><br>
    <button type="submit" name="mode" value="exit">exit</button>
    <button type="submit" name="mode" value="clear">clear</button>
</form>
<% 
int id = 0;
String name = null, dept = null;
double sal = 0;
HttpSession hs = request.getSession(); 
int curLine = 0;
String mode = request.getParameter("mode");
Connection c = null;
PreparedStatement st = null;
ArrayList<Emp> al = new ArrayList<Emp>();
ArrayList<Emp> all = new ArrayList<Emp>();
try {
    Class.forName("org.postgresql.Driver");
    c = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training", "plf_training_admin",
			"pff123");
    st = c.prepareStatement("select * from emplo");
    ResultSet rs = st.executeQuery();
    if(rs.next()) {
        id = rs.getInt(1);
        name = rs.getString(2);
        dept = rs.getString(3);
        sal = rs.getDouble(4);
        Emp e = new Emp(id, name, dept, sal);
        al.add(e);
        all.add(e);
    }
  
    while(rs.next()){
         int iid = rs.getInt(1);
         String nname = rs.getString(2);
         String ddept = rs.getString(3);
         double ssal = rs.getDouble(4);
         Emp e = new Emp(iid, nname, ddept, ssal);
         all.add(e);
    }
} catch (Exception e) {
    System.out.println("error");
}

Integer sessionCurLine = (Integer) hs.getAttribute("curLine");
if (sessionCurLine != null) {
    curLine = sessionCurLine;
}


if (mode != null && mode.equals("first")) {
    if (!all.isEmpty()) {
        curLine = 0;
        hs.setAttribute("curLine", curLine);
        Emp firstEmp = all.get(0);
        id = firstEmp.getId();
        name = firstEmp.getName();
        dept = firstEmp.getDept();
        sal = firstEmp.getSal();
    }
}

if (mode != null && mode.equals("last")) {
    if (!all.isEmpty()) {
        curLine = all.size() - 1;
        hs.setAttribute("curLine", curLine);
        Emp lastEmp = all.get(all.size() - 1);
        id = lastEmp.getId();
        name = lastEmp.getName();
        dept = lastEmp.getDept();
        sal = lastEmp.getSal();
    }
}

if (mode != null && mode.equals("previous")) {
    if (!all.isEmpty() && curLine > 0) {
        curLine -= 1;
        hs.setAttribute("curLine", curLine);
    }
    Emp prevEmp = all.get(curLine);
    id = prevEmp.getId();
    name = prevEmp.getName();
    dept = prevEmp.getDept();
    sal = prevEmp.getSal();
}

if (mode != null && mode.equals("next")) {
    if (!all.isEmpty() && curLine < all.size() - 1) {
        curLine += 1;
        hs.setAttribute("curLine", curLine);
    }
    Emp nextEmp = all.get(curLine);
    id = nextEmp.getId();
    name =nextEmp.getName();
    dept = nextEmp.getDept();
    sal = nextEmp.getSal();
}

if (mode != null && mode.equals("edit")) {
	hs.setAttribute("status",mode);
	Emp pEmp = all.get(curLine);
	id = pEmp.getId();
    name = pEmp.getName();
    dept = pEmp.getDept();
    sal = pEmp.getSal();
}


if (mode != null && mode.equals("delete")) {
	hs.setAttribute("status",mode);
	Emp piEmp = all.get(curLine);
	id = piEmp.getId();
    name = piEmp.getName();
    dept = piEmp.getDept();
    sal = piEmp.getSal();
}

if (mode != null && mode.equals("add")) {
	hs.setAttribute("status",mode);
	
}

if (mode != null && mode.equals("save")) {
	String status = (String)hs.getAttribute("status");
	if (status.equals("add")) {
        String newName = request.getParameter("name");
        String newDept = request.getParameter("dept");
        double newSal = Double.parseDouble(request.getParameter("sal"));

        try {
        	 Class.forName("org.postgresql.Driver");
        	 c = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training", "plf_training_admin",
        				"pff123");
            PreparedStatement insertStatement = c.prepareStatement(
                "INSERT INTO emplo (name, department, salary) VALUES (?, ?, ?)"
            );
            insertStatement.setString(1, newName);
            insertStatement.setString(2, newDept);
            insertStatement.setDouble(3, newSal);
            
         
            insertStatement.executeUpdate();
            
            Emp newEmp = new Emp(0, newName, newDept, newSal);
            all.add(newEmp);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	if (status.equals("delete")) {
		int deletedEmpId = Integer.parseInt(request.getParameter("id"));
        try {
        	Class.forName("org.postgresql.Driver");
       	 	c = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training", "plf_training_admin",
       				"pff123");
            

  
            PreparedStatement deleteStatement = c.prepareStatement(
                "DELETE FROM emplo WHERE id=?"
            );
            deleteStatement.setInt(1, deletedEmpId);

       
            deleteStatement.executeUpdate();

  
           
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	if (status.equals("edit")) {
        String newName = request.getParameter("name");
        String newDept = request.getParameter("dept");
        double newSal = Double.parseDouble(request.getParameter("sal"));

        try {
            int editedEmpId = Integer.parseInt(request.getParameter("id"));


            PreparedStatement updateStatement = c.prepareStatement(
                "UPDATE emplo SET name=?, department=?, salary=? WHERE id=?"
            );
            updateStatement.setString(1, newName);
            updateStatement.setString(2, newDept);
            updateStatement.setDouble(3, newSal);
            updateStatement.setInt(4, editedEmpId);

         
            updateStatement.executeUpdate();

           
            Emp editedEmp = all.get(curLine);
            editedEmp.setName(newName);
            editedEmp.setDept(newDept);
            editedEmp.setSal(newSal);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


System.out.println(curLine);

%>
<script>
var x = "<%= mode %>";
console.log(x);
if(x === "add"){
	var y = document.getElementById("selectt");
	 y.selectedIndex = 1; 
}
if(x === "edit"){
	var y = document.getElementById("selectt");
	 y.selectedIndex = 0; 
}
if(x === "delete"){
	var y = document.getElementById("selectt");
	 y.selectedIndex = 2; 
	 var a = document.getElementById("id");
	 var b = document.getElementById("name");
	 var c = document.getElementById("dept");
	 var d = document.getElementById("sal");
	 a.value = "<%= id %>";
	 b.value = "<%= name %>";
	 c.value = "<%= dept %>";
	 d.value = "<%= sal %>";
}
else{
var a = document.getElementById("id");
var b = document.getElementById("name");
var c = document.getElementById("dept");
var d = document.getElementById("sal");
a.value = "<%= id %>";
b.value = "<%= name %>";
c.value = "<%= dept %>";
d.value = "<%= sal %>";
}

</script>
</body>
</html>

