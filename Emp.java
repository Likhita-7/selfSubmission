package com.crud;

public class Emp {
	int id;
	String name, dept;
	double sal;

	public Emp(int id, String name, String dept, double sal) {
		super();
		this.id = id;
		this.name = name;
		this.dept = dept;
		this.sal = sal;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public double getSal() {
		return sal;
	}

	public void setSal(double sal) {
		this.sal = sal;
	}

}