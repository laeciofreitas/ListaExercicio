<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=utf-8" language="java"
import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript" charset="utf-8" src="<c:url value="/javascript/jquery-1.6.2.min.js"/>"></script>
<script type="text/javascript" charset="utf-8" src="<c:url value="/javascript/jquery.form.js"/>"></script>

<script type="text/javascript" charset="utf-8">	
	function redireciona() {		
		// URL Provisoria
		window.location.href =  '<c:url value="/alunos/home"/>';
	}
	
	$(document).ready(function () {
		var restantes = ${numeroDeQuestoes };		
		
		
		$('.upload').hide();
		
		$('.liberaUpload').click(function() {
			var idDaQuestao = parseInt($(this).attr("id").replace(/\D/g, ''), 10);
			$(this).hide();
			$('#resposta' + idDaQuestao).removeAttr("disabled").show();
		});
		
		<c:forEach items="${listaDeExercicios.questoes}" varStatus="iteracao">
			$('#questao' + ${iteracao.index}).ajaxForm({
				success: function() {
					<c:choose>
						<c:when test="${iteracao.index eq numeroDeQuestoes - 1}">redireciona();</c:when>
						<c:otherwise>$('#questao' + ${iteracao.index + 1}).submit();</c:otherwise>
					</c:choose>	
		        }
			});		
		</c:forEach>
		
		$('#enviaRespostas').click(function() {
			$(this).attr("disabled", "disabled").empty().append("Enviando");
			$('#questao0').submit();
		});
	});
</script>

<style type="text/css">
body
{
background-color:#f0ecc6;
}
h1 
{
color: black;
text-align: center;
font-size: 40px;
font-family:"Times New Roman";
font-style: italic;
font-variant: small-caps;
}
h2
{
color: black;
text-align: center;
font-size: 20px;
font-family:"Times New Roman";
}
.fieldsetSemFormatacao{
	border:none;
	padding: 0px;
}
</style>
</head>
<body>
	<h1>Academic Devoir</h1>
	<h2>Grupo 1 - Engenharia de Software</h2>
	
	<table>
		<tr>
			<td>${listaDeExercicios.propriedades.nome}</td>
		</tr>
		<tr>
			<td>${listaDeExercicios.propriedades.enunciado}</td>
		</tr>
	</table>
	
	<h3>Questões</h3>
	
	<div>
		<c:forEach items="${listaDeExercicios.questoes}" var="questaoDaLista" varStatus="iteracao">
			<form id="questao${iteracao.index }" class="respostaForm" action="<c:url value="/respostas/${listaDeRespostas.id }/cadastra"/>" method="post" accept-charset="us-ascii" enctype="multipart/form-data">
				<fieldset>
						<p>${questaoDaLista.ordem} )
								${questaoDaLista.questao.enunciado}</p>
						${renderizacao[iteracao.index]}
				</fieldset>
			</form>
		</c:forEach>
		<button id="enviaRespostas" type="button">Salvar</button>
	</div>
	
    <a href="<c:url value='/login'/>">Sair</a>
    <!-- TODO a href="<c:url value='/alunos/home'/>">Página Principal</a><br/ -->	
</body>
</html>