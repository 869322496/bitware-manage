import com.qzy.bean.*;
import com.qzy.service.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;

/**
 * @author qingzeyu
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MyTest {
    @Autowired
    EmpService service;
    @Autowired
    DepartmentService service1;
    @Autowired
    MajorService service2;
    @Autowired
    StudentService service3;
    @Autowired
    UsersService service4;
    @Autowired
    ClassService service5;
    @Test
    public void test_login(){
        Emp emp = new Emp();
        emp.setNo("admin");
        emp.setPass("123");
        Emp login = service.login(emp);
        System.out.println(login);
    }
    @Test
    public void test_findAllDepart(){
        List<Depart> allDepart = service.findAllDepart();
        for (Depart depart : allDepart) {
            System.out.println(depart);
        }
    }
    @Test
    public void test01(){

        Depart depart = new Depart();
        depart.setId(15);
        depart.setName("财务部");
        depart.setCreatetime("2019-12-29");
        int i = service1.updateDepartment(depart);
        System.out.println(i);
    }
    @Test
    public void test02(){
        List<Emp> emp = service.getEmp(1, 2);
        System.out.println(emp);
    }
    @Test
    public void test03(){
        Emp emp = service.selectEmpById(1);
        System.out.println(emp);
    }
    @Test
    public void test04(){
        List<MajorType> allMajorType = service2.findAllMajorType();
        System.out.println(allMajorType);
    }
    @Test
    public void test05(){
        List<Major> allMajor = service2.findAllMajor(0, 3);
        System.out.println(allMajor);
    }
    @Test
    public void test06(){
        HashMap<String, Object> map = new HashMap<>();
        map.put("pageStart",0);
        map.put("pageSize",3);
        map.put("class_id",0);
        map.put("name","%"+"%");
        int totalCount = service3.getTotalCount(map);
        System.out.println(totalCount);
    }
    @Test
    public void test07(){
        List<Classes> allClasses = service3.getAllClasses();
        System.out.println(allClasses);
    }
    @Test
    public void test08(){
        Users users = service4.selectUserInfoById(2);
        System.out.println(users);
    }
    @Test
    public void test09(){
        Student studentById = service3.getStudentById(1);
        System.out.println(studentById);
    }
    @Test
    public void test10(){
        List<Classes> allClassesByPage = service5.getAllClassesByPage(0, 1);
        System.out.println(allClassesByPage);
    }
    @Test
    public void test11(){
        List<MajorType> allMajorType = service5.getAllMajorType();
        System.out.println(allMajorType);
    }
    @Test
    public void test12(){
        List<Major> allMajorName = service5.getAllMajorName();
        System.out.println(allMajorName);
    }
    @Test
    public void test13(){
        List<MajorType> allMajorType = service2.findAllMajorType();
        System.out.println(allMajorType);
    }
    @Test
    public void test14(){
        Users users = service4.selectUserInfoById(2);
        System.out.println(users);
    }


}
