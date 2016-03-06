<%@page import="br.com.webproject.domain.Pessoa"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<%@page import="org.hibernate.*"%>
<%@page import="org.hibernate.cfg.*"%>
<%@page import="org.hibernate.service.*" %>
<%@page import="org.hibernate.boot.registry.StandardServiceRegistryBuilder" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <LINK href="estilo.css" type="text/css" rel="stylesheet">
    <title>Hibernate save example Page</title>
  </head>
  <body>
    <h2>Hibernate save example Page</h2>
    <form>
      <p><label>Nome:</label>
      <input type="text" name="nome" /></p>
      <p><label>dataNascimento:</label>
      <input type="date" name="dataNascimento" /></p>
      <p><label>inscricao:</label>
      <input type="text" name="inscricao" /></p>
      <p><label>endereco:</label>
      <input type="text" name="endereco" /></p>
      <p><label>telefone:</label>
      <input type="text" name="telefone" /></p>
      <p><label>email:</label>
      <input type="text" name="email" /></p>
      <p><input type="submit" value="Salvar" /></p>
    </form>
    <%
       int idPessoa = 0;
       String nome = "";
       Date dataNascimento = new Date();
       String inscricao = "";
       String endereco = "";
       String telefone = "";
       String email = "";
       
       if ((request.getParameter("nome") != null)
    		   && (request.getParameter("dataNascimento") != null)
    		   && (request.getParameter("inscricao") != null)
    		   && (request.getParameter("endereco") != null)
    		   && (request.getParameter("telefone") != null)
    		   && (request.getParameter("email") != null)){
         try{
           idPessoa = Integer.parseInt(request.getParameter("idPessoa"));
           nome = request.getParameter("nome");
           inscricao = request.getParameter("inscricao");
           dataNascimento = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dataNascimento"));
           endereco = request.getParameter("endereco");
           telefone = request.getParameter("telefone");
           email = request.getParameter("email");
           SessionFactory sf;
           Configuration configuration = new Configuration().configure("hibernate.cfg.xml");
           configuration.addResource("br/com/webproject/domain/Pessoa.hbm.xml");
           ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().applySettings(
                   configuration.getProperties()).build();
           sf = configuration.buildSessionFactory(serviceRegistry);

           Session s = sf.openSession();//Abre sessão
           Transaction tx = s.beginTransaction();//Cria transação
           Pessoa p = new Pessoa();
           p.setNome(nome);
           p.setEmail(email);
           p.setEndereco(endereco);
           p.setInscricao(inscricao);
           p.setDataNascimento(dataNascimento);
           p.setTelefone(telefone);
           s.save(p);
           tx.commit();
           s.close();
           out.println("Gravou");
         }catch (Exception x){
           out.println(x);
         }
       }
    %>
  </body>
</html>
