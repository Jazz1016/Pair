//
//  PersonController.swift
//  Pair Assesment
//
//  Created by James Lea on 5/21/21.
//

import Foundation


class PersonController {
    static let shared = PersonController()
    
    var groups: [[Person]] = []
    var people: [Person] = []
    
    func addPerson(name: String) {
        let newPerson = Person(name: name)
        if groups.count < 1 {
            groups.append([newPerson])
            saveToPersistentStore()
        } else if groups.count > 0 {
            if groups.last!.count < 2 {
                groups[groups.count - 1].append(newPerson)
                saveToPersistentStore()
            } else {
                groups.append([newPerson])
                saveToPersistentStore()
            }
        }
        
    }
    
    func deletePerson(person: Person) {
        
        
        
        
        var groupIndex = 0
        var personIndex = 0
        var personCounter = -1
        var groupCounter = -1
        for i in groups {
            personCounter = -1
            groupCounter = groupCounter + 1
            for j in i {
                personCounter = personCounter + 1
                if j == person {
                    groupIndex = groupCounter
                    personIndex = personCounter
                }
            }
        }
        
        
        print(groupIndex, personIndex)
        groups[groupIndex].remove(at: personIndex)
        saveToPersistentStore()
        
    }
    
    func randomizeGroups() {
        for i in groups {
            for j in i {
                people.append(j)
            }
        }
        
        groups = []
        saveToPersistentStore()
        
        groupOrganizer()
        func groupOrganizer(){
            if people.count > 0 {
                let number = Int.random(in: 0...people.count - 1)
                if groups.count < 1 {
                    groups.append([people[number]])
                    people.remove(at: number)
                    saveToPersistentStore()
                    groupOrganizer()
                } else if groups.count > 0 {
                    if groups.last!.count < 2 {
                        groups[groups.count - 1].append(people[number])
                        people.remove(at: number)
                        saveToPersistentStore()
                        groupOrganizer()
                    } else {
                        groups.append([people[number]])
                        people.remove(at: number)
                        saveToPersistentStore()
                        groupOrganizer()
                    }
                }
            }
        }
    }
    
    // MARK: - Persistence
    func createPersistentStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("PairAssesment.json")
        return fileURL
    }
    
    func saveToPersistentStore() {
        do {
            let data = try JSONEncoder().encode(groups)
            try data.write(to: createPersistentStore())
        } catch {
            print("ERROR ENCODING SONGS")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: createPersistentStore())
            groups = try JSONDecoder().decode([[Person]].self, from: data)
        } catch {
            print("ERROR LOADING SONGS")
        }
    }
    
}
