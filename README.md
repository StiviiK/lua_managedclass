# Managed Class for LUA
## Features 
- Keeps track of all created instances
- Provides usefull methods like `Class:deleteAll()`
- Singleton implementation (optional, WIP)
- improves the usability of classes and oop in lua
- added ability to implement auto data cleanup for instances (e.g. Elements in MTA)
- uses classlib (https://github.com/sbx320/lua_utils) for better oop experience in lua

## Output of example code
(executed with MTA:SA Server)
```
[16:39:41] INFO: Main.class == Main                :    true    Expected: true
[16:39:41] INFO: DerivedMain.class == DerivedMain  :    true    Expected: true
[16:39:41] INFO: DerivedMain.super == Main         :    true    Expected: true
[16:39:41] INFO: DerivedMain2.super == DerivedMain :    true    Expected: true
[16:39:41] INFO: DerivedMain2.super == Main        :    false    Expected: false
[16:39:41] INFO: DerivedMain3:constructor
[16:39:41] INFO: DerivedMain3:getSingleton()       :    table: 000001E3AD2B7210
[16:39:41] INFO:
[16:39:41] INFO: Main:constructor
[16:39:41] INFO:        Instance:    table: 000001E3AD2B6E50
[16:39:41] INFO:        instanceof(self, ManagedClass)   :    true    Expected: true
[16:39:41] INFO:        instanceof(self, Main)           :    true    Expected: true
[16:39:41] INFO:        self.class == Main               :    true    Expected: true
[16:39:41] INFO: Main:constructor
[16:39:41] INFO:        Instance:    table: 000001E3AD2B6EA0
[16:39:41] INFO:        instanceof(self, ManagedClass)   :    true    Expected: true
[16:39:41] INFO:        instanceof(self, Main)           :    true    Expected: true
[16:39:41] INFO:        self.class == Main               :    true    Expected: true
[16:39:41] INFO: Main:constructor
[16:39:41] INFO:        Instance:    table: 000001E3AD2B6DB0
[16:39:41] INFO:        instanceof(self, ManagedClass)   :    true    Expected: true
[16:39:41] INFO:        instanceof(self, Main)           :    true    Expected: true
[16:39:41] INFO:        self.class == Main               :    true    Expected: true
[16:39:41] INFO: DerivedMain:constructor
[16:39:41] INFO:        Instance:    table: 000001E3AD2B7080
[16:39:41] INFO:        instanceof(self, ManagedClass)   :    true    Expected: true
[16:39:41] INFO:        instanceof(self, Main)           :    true    Expected: true
[16:39:41] INFO:        instanceof(self, DerivedMain)    :    true    Expected: true
[16:39:41] INFO:        self.class == Main               :    false    Expected: false
[16:39:41] INFO:        self.class == DerivedMain        :    true    Expected: true
[16:39:41] INFO: #Main.instances after create                         :    3
[16:39:41] INFO: #DerivedMain.instances after create                  :    1
[16:39:41] INFO: a == b    false
[16:39:41] INFO: a == c    false
[16:39:41] INFO: b == c    false
[16:39:41] INFO: Main:getSingleton() == a    true
[16:39:41] INFO: a:getSingleton() == a       true
[16:39:41] INFO: Main:destructor
[16:39:41] INFO: #Main.instances after delete(b)                      :    2
[16:39:41] INFO: #DerivedMain.instances after delete(b)               :    1
[16:39:41] INFO: b.m_Deleted    true
[16:39:41] INFO: Main:destructor
[16:39:41] INFO: Main:destructor
[16:39:41] INFO: #Main.instances after Main:deleteAll()               :    0
[16:39:41] INFO: #DerivedMain.instances after Main:deleteAll()        :    1
[16:39:41] INFO: a.m_Deleted    true
[16:39:41] INFO: b.m_Deleted    true
[16:39:41] INFO: c.m_Deleted    true
[16:39:41] INFO: d.m_Deleted    nil
[16:39:41] INFO: DerivedMain:destructor
[16:39:41] INFO: #DerivedMain.instances after DerivedMain:deleteAll() :    0
[16:39:41] INFO: d.m_Deleted    true
```