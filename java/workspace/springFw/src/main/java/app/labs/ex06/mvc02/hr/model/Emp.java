package app.labs.ex06.mvc02.hr.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
    // <annotation-driven />: java.util.Date
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date hireDate;
    private String jobId;
    private double salary;
    private double commissionPct;
    private int managerId;
    private int departmentId;
}
