package app.labs.ex03.di04;

public class MemberService implements IMemberService {

	@Override
	public Member getMemberInfo() {
		Member member = new Member();
		member.setMemberId("1234");
		member.setName("오수경");
		member.setAge(24);
		member.setEmail("devwithosk@gmail.com");
		return member;
	}

}
