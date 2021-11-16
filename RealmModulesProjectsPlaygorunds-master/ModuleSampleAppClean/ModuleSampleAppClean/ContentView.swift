//
//  ContentView.swift
//  ModuleSampleAppClean
//
//  Created by Diana Maria Perez Afanador on 4/6/21.
//

import SwiftUI
import ModuleSample
import ModuleSampleDB
import RealmSwift
import Alamofire

@objcMembers public class AppObject: Object {
    dynamic var id: String = ObjectId.generate().stringValue
    dynamic public var name: String = ""

    public override init() {
        super.init()
    }

    public override static func primaryKey() -> String? {
        return "id"
    }
}

struct ContentView: View {
    @State var name1: String = ""
    @State var name2: String = ""
    @State var name3: String = ""

    var body: some View {
        Text("Object from first module \(name1)")
        Text("Object from second module \(name2)")
        Text("Object from main app \(name3)")
            .padding()
            .onAppear(perform: test1)
            .onAppear(perform: test2)
            .onAppear(perform: test3)
    }
//
    func test1() {
        do {
            let key = try Test.addTestObject(ofName: "Maria")
            let object = Test.getObject(ofType: TestObject.self, forPrimaryKey: key)
            name1 = object.name
        } catch {
            print("Error on Realm \(error)")
        }
    }

    func test2() {
        do {
            let key = try Copy.addTestObject(ofName: "Steven")
            let object = Copy.getObject(ofType: CopyObject.self, forPrimaryKey: key)
            name2 = object.name
        } catch {
            print("Error on Realm \(error)")
        }
    }

    func test3() {
        do {
            let realm = try! Realm()
            let appObject = AppObject()
            appObject.name = "Joe"
            try realm.write {
                realm.add(appObject)
            }
            name3 = realm.object(ofType: AppObject.self, forPrimaryKey: appObject.id)!.name
        } catch {
            print("Error on Realm \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

