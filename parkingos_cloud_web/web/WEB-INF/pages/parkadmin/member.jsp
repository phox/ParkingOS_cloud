<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�շ�Ա����</title>
<link href="css/tq.css" rel="stylesheet" type="text/css">
<link href="css/iconbuttons.css" rel="stylesheet" type="text/css">

<script src="js/tq.js?0817" type="text/javascript">//����</script>
<script src="js/tq.public.js?0817" type="text/javascript">//����</script>
<script src="js/tq.datatable.js?0818" type="text/javascript">//����</script>
<script src="js/tq.form.js?0817" type="text/javascript">//����</script>
<script src="js/tq.searchform.js?0817" type="text/javascript">//��ѯ����</script>
<script src="js/tq.window.js?0817" type="text/javascript">//����</script>
<script src="js/tq.hash.js?0817" type="text/javascript">//��ϣ</script>
<script src="js/tq.stab.js?0817" type="text/javascript">//�л�</script>
<script src="js/tq.validata.js?0817" type="text/javascript">//��֤</script>
<script src="js/My97DatePicker/WdatePicker.js" type="text/javascript">//����</script>
</head>
<body>
<div id="memberobj" style="width:100%;height:100%;margin:0px;"></div>
<script language="javascript">
/*Ȩ��*/
var issupperadmin=${supperadmin};
var isadmin = ${isadmin};
var authlist ="";
if((issupperadmin&&issupperadmin==1) || (isadmin&&isadmin==1))
	authlist="0,1,2,3,4,5";
else
	authlist= T.A.sendData("getdata.do?action=getauth&authid=${authid}");
var subauth=[false,false,false,false,false,false];
var ownsubauth=authlist.split(",");
for(var i=0;i<ownsubauth.length;i++){
	subauth[ownsubauth[i]]=true;
}
//�鿴,ע��,�༭,�����շ�,ɾ��,�޸�����
/*Ȩ��*/
var adminroles=eval(T.A.sendData("member.do?action=getrole&adminid=${loginuin}&isadmin="+isadmin+"&comid=${comid}"))
var role=${role};
var comid = ${comid};
var isedit=isadmin==1?true:false;
var _mediaField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��¼�˺�",fieldname:"strid",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ɫ",fieldname:"role_id",fieldvalue:'',inputtype:"select",noList:adminroles ,twidth:"100" ,height:"",issort:false,edit:isedit},
		{fieldcnname:"����ʱ��",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false},
		{fieldcnname:"�����¼ʱ��",fieldname:"logon_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false},
		{fieldcnname:"�շ�",fieldname:"isview",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�����շ�"},{"value_no":1,"value_name":"���շ�"}] , twidth:"60" ,height:"",issort:false}
	];
var _addMemberField = [
		{fieldcnname:"���",fieldname:"id",fieldvalue:'',inputtype:"number", twidth:"100" ,height:"",issort:false,edit:false},
		{fieldcnname:"����",fieldname:"nickname",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�绰",fieldname:"phone",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"�ֻ�",fieldname:"mobile",fieldvalue:'',inputtype:"text", twidth:"100" ,height:"",issort:false},
		{fieldcnname:"��ɫ",fieldname:"role_id",fieldvalue:'',inputtype:"select",noList:adminroles ,twidth:"100" ,height:"",issort:false,edit:isedit},
		{fieldcnname:"����ʱ��",fieldname:"reg_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false},
		{fieldcnname:"�����¼ʱ��",fieldname:"logon_time",fieldvalue:'',inputtype:"date", twidth:"130" ,height:"",edit:false},
		{fieldcnname:"�շ�",fieldname:"isview",fieldvalue:'',inputtype:"select", noList:[{"value_no":-1,"value_name":"ȫ��"},{"value_no":0,"value_name":"�����շ�"},{"value_no":1,"value_name":"���շ�"}] , twidth:"60" ,height:"",issort:false}
	];
var rules =[{name:"strid",type:"ajax",url:"member.do?action=check&value=",requir:true,warn:"�˺��Ѵ��ڣ�",okmsg:""}];
var tabtip = "Ա������";
if(isadmin!=1)
	tabtip +=""
var _memberT = new TQTable({
	tabletitle:tabtip,
	ischeck:false,
	tablename:"member_tables",
	dataUrl:"member.do",
	iscookcol:false,
	//dbuttons:false,
	buttons:getAuthButtons(),
	//searchitem:true,
	param:"action=quickquery&comid="+comid,
	tableObj:T("#memberobj"),
	fit:[true,true,true],
	tableitems:_mediaField,
	isoperate:getAuthIsoperateButtons()
});
function getAuthButtons(){
	var bts=[];
	if(subauth[1])
		bts.push({dname:"ע��Ա��",icon:"edit_add.png",onpress:function(Obj){
		T.each(_memberT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"member_add",Title:"����Ա��",Width:550,sysfun:function(tObj){
				Tform({
					formname: "member_edit_f",
					formObj:tObj,
					recordid:"id",
					suburl:"member.do?action=create&comid="+comid,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_addMemberField}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("member_add");} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"���ӳɹ���",2,"");
							TwinC("member_add");
							_memberT.M();
						}else{
							T.loadTip(1,ret,2,o);
						}
					}
				});	
			}
		})
	
	}});
	if(subauth[0])
		bts.push({dname:"�߼���ѯ",icon:"edit_add.png",onpress:function(Obj){
		T.each(_memberT.tc.tableitems,function(o,j){
			o.fieldvalue ="";
		});
		Twin({Id:"member_search_w",Title:"�����շ�Ա",Width:550,sysfun:function(tObj){
				TSform ({
					formname: "member_search_f",
					formObj:tObj,
					formWinId:"member_search_w",
					formFunId:tObj,
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_mediaField}]
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ������",icon:"cancel.gif", onpress:function(){TwinC("member_search_w");} }
					],
					SubAction:
					function(callback,formName){
						_memberT.C({
							cpage:1,
							tabletitle:"�߼��������",
							extparam:"&comid="+comid+"&action=query&"+Serializ(formName)
						})
					}
				});	
			}
		})
	
	}});
	return bts;
}
//�鿴,ע��,�༭,�����շ�,ɾ��,�޸�����
function getAuthIsoperateButtons(){
	var bts = [];
	if(subauth[2])
	bts.push({name:"�༭",fun:function(id){
		T.each(_memberT.tc.tableitems,function(o,j){
			o.fieldvalue = _memberT.GD(id)[j]
		});
		Twin({Id:"member_edit_"+id,Title:"�༭",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "member_edit_f",
					formObj:tObj,
					recordid:"member_id",
					suburl:"member.do?comid="+comid+"&action=edit&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:_memberT.tc.tableitems}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���༭",icon:"cancel.gif", onpress:function(){TwinC("member_edit_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�༭�ɹ���",2,"");
							TwinC("member_edit_"+id);
							_memberT.M();
						}else if(ret=="2"){
							T.loadTip(1,"һ������ֻ����һ������Ա����༭֮ǰ�Ĺ���ԱΪ������ɫ",30,"");
							TwinC("member_edit_"+id);
							_memberT.M();
						}else{
							T.loadTip(1,"�༭ʧ�ܣ�",2,o)
						}
					}
				});	
			}
		})
	}});
	if(subauth[3])
	bts.push({name:"�����շ�",
		rule:function(id){
				var state =_memberT.GD(id,"isview");
				if(state==1){
					this.name="�����շ�";
				}else{
					this.name=" &nbsp;<font color='red'>���շ�</font>&nbsp;      ";
				}
				return true;
			},
		tit:"�����Ƿ�����շ�",
		fun:function(id){
			var state =_memberT.GD(id,"isview");
			var type = "���շ�";
			var isview = 1;
			if(state==1){
				type = "�����շ�";
				isview = 0;
			}
			Tconfirm({
				Title:"��ʾ��Ϣ",
				Ttype:"alert",
				Content:"���棺��ȷ��Ҫ <font color='red'>"+type+"</font> ��",
				OKFn:function(){
				T.A.sendData("member.do?action=isview&id="+id+"&isview="+isview,"GET","",
					function(ret){
						if(ret=="1"){
							T.loadTip(1,"����"+type+"�ɹ���",2,"");
							_memberT.C();
						}else{
							T.loadTip(1,"����ʧ�ܣ������ԣ�",2,"")
						}
					},0,null)
				}
			});
		}});
	if(subauth[4]&&isadmin==1)
	bts.push({name:"ɾ��",fun:function(id){
		var id_this = id ;
		Tconfirm({Title:"ȷ��ɾ����",Content:"ȷ��ɾ����",OKFn:function(){T.A.sendData("member.do?action=delete","post","selids="+id_this,
			function deletebackfun(ret){
				if(ret=="1"){
					T.loadTip(1,"ɾ���ɹ���",2,"");
					_memberT.M()
				}else{
					T.loadTip(1,ret,2,"");
				}
			}
		)}})
	}});
	if(subauth[5])
	bts.push({name:"�޸�����",fun:function(id){
		T.each(_memberT.tc.tableitems,function(o,j){
			o.fieldvalue = _memberT.GD(id)[j]
		});
		Twin({Id:"member_pass_"+id,Title:"�޸�����",Width:550,sysfunI:id,sysfun:function(id,tObj){
				Tform({
					formname: "member_pass_f",
					formObj:tObj,
					recordid:"member_id",
					suburl:"member.do?action=editpass&id="+id,
					method:"POST",
					formAttr:[{
						formitems:[{kindname:"",kinditemts:[
							{fieldcnname:"������",fieldname:"newpass",fieldvalue:'',inputtype:"password", twidth:"200" ,height:"",issort:false},
							{fieldcnname:"ȷ������",fieldname:"confirmpass",fieldvalue:'',inputtype:"password", twidth:"200" ,height:"",issort:false}]}]
						//rules:rules
					}],
					buttons : [//����
						{name: "cancel", dname: "ȡ��", tit:"ȡ���ɹ�",icon:"cancel.gif", onpress:function(){TwinC("member_pass_"+id);} }
					],
					Callback:
					function(f,rcd,ret,o){
						if(ret=="1"){
							T.loadTip(1,"�޸ĳɹ���",2,"");
							TwinC("member_pass_"+id);
							_memberT.M()
						}else{
							T.loadTip(1,ret,2,o)
						}
					}
				});	
			}
		})
	}});
	if(bts.length <= 0){return false;}
	return bts;
}
_memberT.C();
</script>

</body>
</html>