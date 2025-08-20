package app.labs.ex03.di04;

public class Member {
	// 멤버변수
	private String memberId;
	private String name;
	private int age;
	private String email;
	
	// 생성자
    public Member() {
    }
    
    // getter() / setter()
	public String getMemberId() {
		return memberId;
	}



	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public int getAge() {
		return age;
	}



	public void setAge(int age) {
		this.age = age;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	// toString()
	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", name=" + name + ", age=" + age + ", email=" + email + "]";
	}

}
