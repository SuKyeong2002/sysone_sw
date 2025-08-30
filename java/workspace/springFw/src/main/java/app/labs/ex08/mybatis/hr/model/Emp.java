package app.labs.ex08.mybatis.hr.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Emp {
	private int employeeId;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    // 매핑을 알아서 잘 해주기 때문에 Date -> String
    private String hireDate;
    private String jobId;
    private double salary;
    private double commissionPct;
    private int managerId;
    private int departmentId;
}
