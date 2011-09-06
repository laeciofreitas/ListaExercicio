package br.usp.ime.academicdevoir.entidades;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.OneToMany;

@Entity
public class Professor extends Usuario {
	@OneToMany(mappedBy = "professor")
	private Collection<Turma> turmas = new ArrayList<Turma>();


	public Collection<Turma> getTurmas() {
		return turmas;
	}

	public void setTurmas(Collection<Turma> turmas) {
		this.turmas = turmas;
	}
}