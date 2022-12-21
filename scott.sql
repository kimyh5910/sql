select staff.empno, staff.ename, manager.empno, manager.ename
    from emp staff, emp manager
    where staff.mgr = manager.empno
    and staff.empno = 7788;
    
select staff.empno, staff.ename, manager.empno, manager.ename
from emp staff,emp manager;

