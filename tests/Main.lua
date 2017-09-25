DEBUG = true
Main = inherit(ManagedClass)
DerivedMain = inherit(Main)
DerivedMain2 = inherit(DerivedMain)
DerivedMain3 = inherit(DerivedMain2)
SingletonMain = inherit(ManagedSingleton)

function Main:constructor()
    print("Main:constructor")
    print("\tInstance:", self)
    print("\tinstanceof(self, ManagedClass)   :", instanceof(self, ManagedClass), "Expected: true")
    print("\tinstanceof(self, Main)           :", instanceof(self, Main), "Expected: true")
    print("\tself.class == Main               :", self.class == Main, "Expected: true")
end

function Main:destructor()
    print("Main:destructor")
    self.m_Deleted = true
end

function DerivedMain:constructor()
    print("DerivedMain:constructor")
    print("\tInstance:", self)
    print("\tinstanceof(self, ManagedClass)   :", instanceof(self, ManagedClass), "Expected: true")
    print("\tinstanceof(self, Main)           :", instanceof(self, Main), "Expected: true")
    print("\tinstanceof(self, DerivedMain)    :", instanceof(self, DerivedMain), "Expected: true")
    print("\tself.class == Main               :", self.class == Main, "Expected: false")
    print("\tself.class == DerivedMain        :", self.class == DerivedMain, "Expected: true")
end

function DerivedMain:destructor()
    print("DerivedMain:destructor")
    self.m_Deleted = true
end

function DerivedMain3:constructor()
    print("DerivedMain3:constructor")
end

function main()
    print("Main.class == Main                :", Main.class == Main, "Expected: true")
    print("DerivedMain.class == DerivedMain  :", DerivedMain.class == DerivedMain, "Expected: true")
    print("DerivedMain.super == Main         :", DerivedMain.super == Main, "Expected: true")
    print("DerivedMain2.super == DerivedMain :", DerivedMain2.super == DerivedMain, "Expected: true")
    print("DerivedMain2.super == Main        :", DerivedMain2.super == Main, "Expected: false")
    print("SingletonMain:getSingleton()      :", SingletonMain:getSingleton())
    print("")

    a = Main:new()
    b = Main:new()
    c = Main:new()
    d = DerivedMain:new()
    e = SingletonMain:getSingleton()

    print("#Main.instances after create                         :", #Main.instances)
    print("#DerivedMain.instances after create                  :", #DerivedMain.instances)

    print("a == b", a == b)
    print("a == c", a == c)
    print("b == c", b == c)

    print("SingletonMain:getSingleton() == e", SingletonMain:getSingleton() == e)
    print("SingletonMain:new() == nil       ", SingletonMain:new() == nil)

    if true then
        delete(b)
        print("#Main.instances after delete(b)                      :", #Main.instances)
        print("#DerivedMain.instances after delete(b)               :", #DerivedMain.instances)
        print("b.m_Deleted", b.m_Deleted)
    end

    if true then
        Main:deleteAll()
        print("#Main.instances after Main:deleteAll()               :", #Main.instances)
        print("#DerivedMain.instances after Main:deleteAll()        :", #DerivedMain.instances)
        print("a.m_Deleted", a.m_Deleted)
        print("b.m_Deleted", b.m_Deleted)
        print("c.m_Deleted", c.m_Deleted)
        print("d.m_Deleted", d.m_Deleted)
    end

    if true then
        DerivedMain:deleteAll()
        print("#DerivedMain.instances after DerivedMain:deleteAll() :", #DerivedMain.instances)
        print("d.m_Deleted", d.m_Deleted)
    end
end
main()
