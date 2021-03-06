﻿<Project Name="TestProject">
	<Property Name="UDT">
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd" />
		<Release Version="1.0.0.0" URL="udm/UDT_1_0_0_0.tcmd"></Release>
	</Property>
	<Property Name="UDS">
		<Contract Name="TestUDS" Enabled="True">
	<Definition AutoUpdateSource="http://dev.ischool.com.tw:8080/cs4/spec">
	<!--<Authentication Extends="auth.student"/>-->
<Authentication>
	<Public Enabled="True" />
	</Authentication>
</Definition>
	<Package Name="_">
		<Service Enabled="true" Name="AutoTeacherCode">
			<Definition Type="dbhelper">
				<Action>Insert</Action>
				<SQLTemplate><![CDATA[INSERT INTO teacher @@FieldList]]></SQLTemplate>
				<RequestRecordElement>Teacher</RequestRecordElement>
				<FieldList Name="FieldList" Source="Field">
					<Field Source="Id" Target="id" />
					<Field Source="TeacherName" Target="teacher_name" />
					<Field InputConverter="AutoCode" Quote="False" Source="TeacherCode" Target="teacher_code" />
				</FieldList>
				<Converters>
					<Converter Name="AutoCode" Type="Mapping">
						<Item If="">substring(cast(uuid_generate_v4() as text) from 2 for 6)</Item>
					</Converter>
				</Converters>
			</Definition>
		</Service>
		<Service Enabled="true" Name="ComTestService">
			<Definition Type="Component">
				<ClassName>dsa.test.TestService</ClassName>
				<MethodName>execute</MethodName>
				<Resources />
			</Definition>
		</Service>
		<Service Enabled="true" Name="DSAClassLoader">
			<Definition Type="Component">
				<ClassName>classloaderdeploy.ClassLoaderTestService</ClassName>
				<MethodName>execute</MethodName>
			</Definition>
		</Service>
		<Service Enabled="true" Name="GetChildClassmate">
			<Definition Type="javascript">
	<Code>
		<![CDATA[

		_Students = executeSql('select id,name,birthdate,id_number,custodian_name,student_number from student limit 15').toArray();
		
		// 回傳
		return {Student : _Students};
		]]></Code>
</Definition>
		</Service>
		<Service Enabled="true" Name="GetChildCourse">
			<Definition Type="javascript">
	<Code><![CDATA[_Courses = executeSql('select * from course order by id limit 10').toArray();

// 回傳
return {Course: _Courses};]]></Code>
</Definition>
		</Service>
		<Service Enabled="true" Name="ListModules">
			<Definition Type="Component">
	<ClassName>ischool.udm.service.UDMService</ClassName>
	<MethodName>listModules</MethodName>
	<!--註aa-->
</Definition>
		</Service>
		<Service Enabled="true" Name="ResponseType">
			<Definition MandatoryResponseType="JSON" Type="JavaScript">
	<Code>
		<![CDATA[
	return {Response:'content'};
	]]></Code>
</Definition>
		</Service>
		<Service Enabled="true" Name="SMSCallback">
			<Definition Type="JavaScript">
	<Code>var request = getRequest();

var mobile = request.smsResp.mobile;
var msgid = request.smsResp.msgid;
var statuscode = request.smsResp.statuscode;
var statustext = request.smsResp.statustext;

executeSql("insert into $sms_history(sms_rsp,mobile,msgid,statuscode,statustext) values('"+ JSON.stringify(request) +"','" + mobile +"','" + msgid + "','" + statuscode + "','" + statustext + "')");
</Code>
</Definition>
		</Service>
		<Service Enabled="true" Name="SelectPackage">
			<Definition Type="dbhelper">
				<Action>Select</Action>
				<!--縮什麼縮！-->
				<SQLTemplate><![CDATA[SELECT @@FieldList FROM $system.packagedefinition WHERE @@Condition]]></SQLTemplate>
				<ResponseRecordElement>Response/System.packagedefinition</ResponseRecordElement>
				<FieldList Name="FieldList" Source="Field">
					<Field Alias="Uid" Mandatory="True" Source="Uid" Target="uid" />
					<Field Alias="LastUpdate" Mandatory="True" Source="LastUpdate" Target="last_update" />
					<Field Alias="Definition" Mandatory="True" OutputType="Xml" Source="Definition" Target="definition" />
					<Field Alias="Order" Mandatory="True" Source="Order" Target="&quot;order&quot;" />
					<Field Alias="Reftagid" Mandatory="True" Source="Reftagid" Target="reftagid" />
					<Field Alias="Targettype" Mandatory="True" Source="Targettype" Target="targettype" />
				</FieldList>
				<Conditions Name="Condition" Required="False" Source="Condition" />
				<Code>	
	
	var each_record = functio(record){
		record.teacher_name = lookup(request.ref_teacher_id);
		
		function(refid){
			//....
			return teacher_name;
		}
	}
		
	var each_request_pre = function(request){
	}
	
	var each_request_post = function(request){
	if(request.Cond)
	
	}
	</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="SendMail">
			<Definition Type="Component">
				<ClassName>ischool.uds.helperservice.MailService</ClassName>
				<MethodName>sendmail</MethodName>
				<Resources>
					<Resource Name="SmtpConfiguration">
						<SmtpConfiguration>
							<Host>smtp.mandrillapp.com</Host>
							<Port>587</Port>
							<Account>embacourse@emba.ntu.edu.tw</Account>
							<Password>K7DhiWwc9C5ZExhoXB_GPg</Password>
						</SmtpConfiguration>
					</Resource>
					<Resource Name="SmtpConfigurationSql"><![CDATA[
			SELECT account, password, 'smtp.mandrillapp.com' as host, '587' as port FROM $ischool.emba.cs_email_account order by uid limit 1
    	]]></Resource>
				</Resources>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestCDATASection">
			<Definition Type="JavaScript">
				<Code><![CDATA[var obj = {};
obj.Att1 = 'abc';
obj.Att2 = 'def';

var rsp = {};
rsp.Root = raw('&gt![CDATA[' + JSON.stringify(obj) + ']]&lt');
//rsp.SecondRoot= 'second root value';

return rsp;]]></Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestDBDateTimeTOJSDateTime">
			<Definition Type="JavaScript">
				<!--<Engine>Rhino</Engine>-->
				<Code>var request = getRequest().Request;

var result = executeSql('select birthdate,name,id_number,ref_class_id from student limit 10;');

result.next();

var rsp = {};
rsp.BirthdateOrigin = result.get('birthdate');
rsp.Birthdate = util.toDate(result.get('birthdate'), 'yyyy-MM-dd HH:mm:ss');
rsp.ISOString = util.toDate(new Date().toISOString(), "yyyy-MM-dd'T'HH:mm:ss");
rsp.DateToString = new Date().toString();
rsp.DBDateTime = getDBDateTime();
rsp.DBDateTimeReNew = new Date(rsp.DBDateTime.getTime());
rsp.DBDateTimeGetTime = rsp.DBDateTime.getTime();

rsp.FormatDate = new Date().format("yyyy-MM-dd HH:mm");
rsp.DateParse = new Date(Date.parse('Fri Jun 21 2013 15:40:56 GMT+0800 (CST)'));

return {
    Response: rsp
};</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestDBHelper">
			<Definition Type="dbhelper">
	<Action>Select</Action>
	<SQLTemplate>
		<![CDATA[
	SELECT @@FieldList FROM exam WHERE @@Condition @@Order
		limit 2
	]]></SQLTemplate>
	<ResponseRecordElement>__Body/Exam</ResponseRecordElement>
	<FieldList Name="FieldList" Source="Field">
		<Field Alias="Id" Mandatory="True" Source="Id" Target="id" />
		<Field Alias="ExamName" Mandatory="True" Source="ExamName" Target="exam_name" />
		<Field Alias="Description" Mandatory="True" Source="Description" Target="description" />
		<Field Alias="DisplayOrder" Mandatory="True" Source="DisplayOrder" Target="display_order" />
	</FieldList>
	<Conditions Name="Condition" Required="False" Source="Condition">
		<Condition Source="Id" Target="id" />
		<Condition Source="ExamName" Target="exam_name" />
		<Condition Source="Description" Target="description" />
		<Condition Source="DisplayOrder" Target="display_order" />
	</Conditions>
	<Orders Name="Order" Source="Order" />
	<Pagination Allow="True" />
</Definition>
		</Service>
		<Service Enabled="true" Name="TestDBTransaction">
			<Definition Type="JavaScript">
				<!--<Engine>Rhino</Engine>-->
				<Code><![CDATA[
		var response = {};

		var result = executeSql("insert into tag(prefix,name,category) values('AB','AB','Student')");

		var result = executeSql("insert into tag(prefix,name,category) values('AB1','AB1','Student')");

		//throwError('炸爆掉！','001');
	]]></Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestDateTime">
			<Definition Type="JavaScript">
				<!--<Engine>Rhino</Engine>-->
				<Code>var request = getRequest().Request;
var rsp = {};

rsp.toJSON = new Date().toJSON();
rsp.toString = new Date().toString();
rsp.toDateString = new Date().toDateString();
rsp.toISOString = new Date().toISOString();
rsp.Format = new Date().toString('yyyy-MM-dd HH:mm:ss');

rsp['@Accept'] = '資料庫爆炸';

return {
    Response: rsp
};</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestGetTeacher">
			<Definition Type="JavaScript">
				<Code>//這是很棒的方式!!
var _request = getRequest().Request;
var _response = [];
var _rs;
var _sql = getResource('sql1');
var _myId = getContextProperty('StudentID');
var _teachers = [];

_sql += ' where sid=' + _myId;
_sql += (_request &amp;&amp; _request.SchoolYear) ? ' and school_year=' + _request.SchoolYear : '';
_sql += (_request &amp;&amp; _request.Semester) ? ' and semester=' + _request.Semester : '';
_rs = executeSql(_sql);
// throwError('請提供學年度, 學期', '400');

while (_rs.next()) {
    if (!_teachers[_rs.get('teacher_id')]) {
        _teachers[_rs.get('teacher_id')] = {
            TeacherId: _rs.get('teacher_id'),
            TeacherName: _rs.get('teacher_name'),
            Gender: _rs.get('gender'),
            ClassInstructor: false,
            Course: []
        };
        _teachers.push(_teachers[_rs.get('teacher_id')]);

        var teacher = _teachers[_rs.get('teacher_id')];
        if (_rs.get('kind') === 'class') {
            teacher.ClassInstructor = true;
        } else {
            teacher.Course.push({
                CourseId: _rs.get('course_id'),
                Subject: _rs.get('subject'),
                SchoolYear: _rs.get('school_year'),
                Semester: _rs.get('semester'),
                Sequence: _rs.get('sequence')
            })
        }
    }
}

return {
    Teacher: _teachers
};</Code>
				<Resources>
					<Resource Name="sql1">
			SELECT * from (
			SELECT student.id sid
			,student.gender
			, 'class' kind
			, teacher.id teacher_id
			, teacher.teacher_name
			, case teacher.gender when '1' then '男' when '0' then '女' else '' end
			, null course_id
			, null subject
			, null school_year
			, null semester
			, null "sequence"
			FROM class JOIN student on student.ref_class_id = class.id
			JOIN teacher on teacher.id = class.ref_teacher_id
			UNION
			SELECT student.id sid
			,student.gender
			, 'course' kind
			, teacher.id teacher_id
			, teacher.teacher_name
			, case teacher.gender when '1' then '男' when '0' then '女' else '' end
			, course.id course_id
			, course.subject
			, course.school_year
			, course.semester
			, tc_instruct.sequence "sequence"
			FROM student
			JOIN sc_attend on sc_attend.ref_student_id = student.id
			JOIN course on course.id = sc_attend.ref_course_id
			JOIN tc_instruct on tc_instruct.ref_course_id = course.id
			JOIN teacher on teacher.id = tc_instruct.ref_teacher_id
			) myTable
		</Resource>
				</Resources>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestGetUserInfo">
			<Definition Type="JavaScript">
				<!--<Engine>Rhino</Engine>-->
				<Code>var userName = getContextProperty('UserName');
var result = executeSql('select id "ID",name "Name",id_number "IDNumber" from student where sa_login_name=\'' + userName + '\'');
var response = {
    Root: []
};

while (result.next()) {
    var stu = {};
    var columns = result.getColumns();
    for (var i = 0; i &lt; columns.length; i++) {
        var item = columns[i];
        stu[item] = raw(result.get(item));
    }
    response.Root.push(stu);
}
return response;

/*
	var response = {Content:{}};
	var root  = response.Content;
	
	root.Time1 = getDBDateTime();
	root.Content = raw(httpGet('https://raw.github.com/ischool-tw/dsa5/master/RoleDefinitionSpec.xml?login=gildarts&amp;token=6c820f3ebac090184ddd6e50e0457f42'));
	root.Time2 = getDBDateTime();
	root.TimeDiff = root.Time2 - root.Time1;
	
	var t1 = getDBDateTime();
	print(getDBDateTime() - t1);
	
	print('data!');
	
	return response;
	*/
</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestHsinchuWS">
			<Definition Type="JavaScript">
	<Code>var req = getRequest().Request;

var toSch = req.TargetSchool;
var stuID = req.StudentID;
var writer = req.Writer;
var birthday = req.Birthday;
var stuNo = req.StudentNumber;
var sGrade = req.Grade;
var sClass = req.ClassName;

//var url = 'http://163.19.149.20/iccard/ws/trans.asmx/tOut?name=%E7%8E%8B%E5%A4%A7%E6%98%8E&amp;std_id=A123456789&amp;to_sch=183502&amp;write_id=Yaoming&amp;birthday=20000101';

url = 'http://163.19.149.20/iccard/ws/trans.asmx/tIn?to_sch=183511A&amp;write_id=Yaoming&amp;std_id=A123456789&amp;std_no=19999&amp;sGrade=3&amp;sClass=301';
var result = httpGet(url);

return {
    Response: xml2json.parser(result)
};</Code>
</Definition>
		</Service>
		<Service Enabled="true" Name="TestHttp">
			<Definition Type="JavaScript">
				<!--<Engine>Rhino</Engine>-->
				<Code>var val = (httpGet('https://gist.github.com/gildarts/5755987/raw/a73ac5e6a6aa813a4c93ffee72ce1269c660cd59/JSHelper.java'));
return {
    Response: (val)
};</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestIsArray">
			<Definition Type="JavaScript">
	<Code>[2, 5, 9].forEach(function (elm, index, array) {
    //print('a[' + index + '] = ' + elm);
});</Code>
</Definition>
		</Service>
		<Service Enabled="true" Name="TestJSResultSetString">
			<Definition Type="JavaScript">
				<Code>var result = executeSql("select 'class' kind,'student' student")

var rsp = {};

while (result.next()) {
    if (result.get('kind') === 'class') {
        rsp.Kind1 = 'true';
    }

    if (result.get('kind') == 'class') {
        rsp.Kind2 = 'true';
    }

    rsp.Value = result.get('kind');
}

rsp.Fields = result.getColumns();

return {
    Response: rsp
};</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestJavaScript">
			<Definition Type="JavaScript">
				<!--<Engine>Rhino</Engine>-->
				<Code>var request = getRequest().Request;
var response = {};

response.Students = {
    Student: []
};

var studs = response.Students.Student;

$.each(request.Message, function (index, item) {
    var stud = {};
    stud['@ID'] = item.ID;
    stud.Message = item['@text'];
    stud.Err = {};
    stud.Err.Msg = 'my msg';
    stud.Err.Fun = function () {}
    stud.Info = new Date();

    if (item.Name) stud.Name = item.Name;

    studs.push(stud);
});

print('content is :' + request.BOMB);
print(getResource('sql'));
print(getResource('xml'));</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestJavaScriptDBAccess">
			<Definition Type="JavaScript">
				<Code>var request = getRequest().Request;
var response = {};

var result = {};
try {
    var result = executeSql('select * from $校車系統.校車路線;');
    //throw {code:'500', message: 'hi炸了!'};
} catch(e) {
    return {
        'Sql訊息': e.javaException
    };
}

response = {
    Student: []
};

while (result.next()) {
    var stu = {};

    var columns = result.getColumns();
    for (var i = 0; i &lt; columns.length; i++) {
        var item = columns[i];
        eval('stu.' + item + ' = raw(result.get("' + item + '"))');
    }

    response.Student.push(stu);
}

return {
    Response: response
};</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestJavaScriptDBUpdate">
			<Definition Type="JavaScript">
				<!--<Engine>Rhino</Engine>-->
				<Code>var request = getRequest().Request;
var response = {};

var result = executeSql("update student set enrollment_type = '天上下凡' where id in ('49611','49616','49617') ");

response.Response = {
    Student: []
};

response.Response.AffectCount = result;

response.Response.ObjType = result;</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestJavaScriptException">
			<Definition Type="JavaScript">
	<!--<Engine>Rhino</Engine>-->
	<Code>var request = getRequest().Request;
		var response = {};

		//if(a,b,c){}

try{
	executeSql('select * from student limit 1');
}catch(e){
	var msg = e;
	if(e.javaException)
		msg = new String(e.javaException.getMessage());

		throw {code:'123',msg: msg, detail:''};
}

		//if(===){}
		
		throwError('DSA Service 發生了大爆炸~','0F8')
		//throw {a:'v1'};
		//throw 'hello~爆炸了!';//{code:'0f8', msg:'abcdef'};
		//throw {code:'0f8', msg:'執行 sql 發生錯誤~',detail:'自定的 detail...'};
	</Code>
</Definition>
		</Service>
		<Service Enabled="true" Name="TestJavaScriptXmlContent">
			<Definition Type="JavaScript">
				<Code>var request = getRequest().Request;
var response = {};
var result = executeSql('select id,name,id_number,enrollment_type,sems_history,mailing_address from student order by id limit 10;');

response.Response = {};
//測 xml2json。
response.Response.Xml = xml2json.parser('&lt;root&gt;&lt;child&gt;child content&lt;/child&gt;&lt;/root&gt;');
//{IsSchoolAdmin=0, StudentID=-1, IPAddress=59.120.55.240, TeacherID=8641, Role=Teacher}
response.Response.IPAddress = getContextProperty('IPAddress');
response.Response.IsSchoolAdmin = getContextProperty('IsSchoolAdmin');
response.Response.StudentID = getContextProperty('StudentID');
response.Response.TeacherID = getContextProperty('TeacherID');
response.Response.Role = getContextProperty('Role');
response.Response.ObjType = result;

response.Response.Student = [];
while (result.next()) {
    var stu = {};
    stu.Name = result.get('name');
    stu.IDNumber = result.get('id_number');
    stu.EnrollmentType = result.get('enrollment_type');
    stu.SemsHistory = raw(result.get('sems_history'));
    stu.Address = xml2json.parser(result.get('mailing_address'));

    response.Response.Student.push(stu);
}

return response;</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestJsonToXml">
			<Definition Type="JavaScript">
	<Code>var parser = parseXml.CreateParser();
var xml = parser.parse({a:'hi', b:'hello'});

return {Response: raw(xml)}</Code>
</Definition>
		</Service>
		<Service Enabled="true" Name="TestMomentLib">
			<Definition Type="JavaScript">
				<Code>print('hi');

return {
    Moment: moment().format('YYYY/MM/DD HH:mm:ss')
};</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestMultiRoot">
			<Definition Type="JavaScript">
				<Code><![CDATA[
	var req = getRequest();
	return {v: req.A, b: req.B};
	]]></Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestPrint">
			<Definition Type="JavaScript">
				<Code>var fun = function () {
    alert('hi~bomb~~');
}
print(fun);</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestResultSetToArray">
			<Definition Type="JavaScript">
				<Code>var request = getRequest().Request;
var response = {};

var result = executeSql('select birthdate,name,id_number,ref_class_id from student limit 10;');

return {
    Response: {校車路線: result.toArray()
    }
};</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestReturnArray">
			<Definition Type="JavaScript">
				<Code><![CDATA[
	return [{a:'b',c:'d'}];
	]]></Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestReturnRequest">
			<Definition Type="JavaScript">
	<Code>	return {Response: getRequest()};
	</Code>
</Definition>
		</Service>
		<Service Enabled="true" Name="TestTransactionErrorContinueRun">
			<Definition Type="JavaScript">
				<!--<Engine>Rhino</Engine>-->
				<Code>
		var request = getRequest().Request;
		var response = {};

		var result = executeSql('select birthdate,name,id_number,ref_class_id from student limit 10;');
		commitTransaction();
		
		try{
			executeSql('select * from student limit 1==');
			commitTransaction();
		}catch(ex){
			print('bomb');
			rollbackTransaction();
		}

		var result1 = executeSql('select birthdate,name,id_number,ref_class_id from student limit 10;');
		commitTransaction();
		
		return {Response: {校車路線: result.toArray(),Result1:result1.toArray()}};
	</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestXml2Json">
			<Definition Type="JavaScript">
				<Code>
 var sql = "SELECT content FROM list WHERE name='學校資訊'"
var rs = executeSql(sql).toArray();
var result = xml2json.parser(rs[0].content);
return {Result: result};
	</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="TestXmlEncodeing">
			<Definition Type="JavaScript">
				<Code>var trim = function (data) {
    var json = xml2json.parser(data);

    if (json.Configurations) {
        if (json.Configurations.Configuration) return raw((xml2json.parser(data).Configurations.Configuration['@text']));
        else return raw(json);
    }
    else return raw(json);
}

var rsp = {};

rsp.Normal = '&lt;XmlNode/&gt;';

rsp.Raw = raw(('&lt;XmlNode/&gt;'));

rsp.Decode = raw(decodeXml('&amp;lt;XmlNode/&amp;gt;'));
rsp.Encode = raw(encodeXml('&lt;root/&gt;'));

var data = executeSql("select * from list");

var list = [];
while (data.next()) {
    list.push(trim(data.get('content')));
}
rsp.List = list;

return {
    Response: rsp
};</Code>
			</Definition>
		</Service>
		<Service Enabled="true" Name="WoodstoxTest">
			<Definition Type="Component">
				<ClassName>dsa.test.WoodstoxTest</ClassName>
				<MethodName>execute</MethodName>
				<Resources />
			</Definition>
		</Service>
	</Package>
</Contract>
	</Property>
</Project>