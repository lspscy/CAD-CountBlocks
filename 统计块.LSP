;【统计块】

(defun c:tjk(/  pt1 pt2 ss e el n f2 attlist att_txt ecvla timenow)

   (vl-load-com)
   
   (setq pt1 (getpoint "请选择图形左上角:\n"))
   (setq pt2 (getcorner pt1 "请选择图形右下角:\n"))
   (PRINC "\n统计块，反馈请联系:李劲松（18919611085） \n")(PRINC)
   

   (setq ss (ssget "_W" pt1 pt2  '((0 . "insert" ))))
   (if (/= ss nil) 
     (progn
       (setq n 0) ;序号的初值为0
       (setq f2(open "F:\\图块列表.txt" "a"));打开数据文件
       (setq timenow (menucmd "M=$(edtime,$(getvar,date),YYYY MONTH DD \"日\"HH\":\"MM\":\"SS)"))
       (write-line timenow f2);写入当前时间
       (repeat (sslength ss);重复执行，执行的次数等于所选对象的个数  
         (setq e(ssname  ss  n));得到选择集内第n个对象的图元名
         (setq el(entget e));得到这个对象的图元表
         (setq  att_txt (strcat  (itoa n) '"\-" (cdr(assoc 8 el)) "\-" (cdr(assoc 2 el)) ));取序号-图层-图块名
         (write-line att_txt f2);写入内容
         (setq n(1+ n)) ;序号n的数量加1
       )
       (close f2)
     )
     
   )
   
)

