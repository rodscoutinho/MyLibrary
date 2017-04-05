//
//  MembersTableViewController.swift
//  FinalProject
//
//  Created by Rodrigo Coutinho on 21/03/17.
//  Copyright © 2017 Rodrigo Coutinho. All rights reserved.
//

import UIKit
import MapKit

protocol MembersTableViewControllerDelegate: class {
    func membersTableViewController(_ controller: MembersTableViewController, didFinishSelecting member: Member)
}

class MembersTableViewController: UITableViewController {

    var members = [Member]()
    weak var delegate: MembersTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let member1 = Member(name: "Hilel Sykes", phone: "1-230-468-0413", address: "506 Arcu. Av.", email: "felis@Nunc.com")
        let member2 = Member(name: "Suki Powers", phone: "1-789-198-8648", address: "809 Nunc Av.", email: "lobortis.quam.a@turpisnecmauris.ca")
        let member3 = Member(name: "Preston Barron", phone: "1-335-551-4340", address: "P.O. Box 751, 1279 Tempor Street", email: "mattis.Integer@acmetusvitae.net")
        let member4 = Member(name: "MacKenzie Frederick", phone: "1-210-982-3915", address: "Ap #634-1466 Metus Ave", email: "fames@velvenenatisvel.ca")
        let member5 = Member(name: "Quinn Hess", phone: "1-357-406-8021", address: "P.O. Box 625, 497 Id, Ave", email: "vel@Nunc.org")
        let member6 = Member(name: "Amy Maddox", phone: "1-999-755-7510", address: "P.O. Box 776, 2745 letius. St.", email: "et.lacinia.vitae@adipiscingelitCurabitur.org")
        let member7 = Member(name: "Holly Frye", phone: "1-733-250-9612", address: "P.O. Box 714, 1209 Libero Rd.", email: "nisi@Donecnibhenim.ca")
        let member8 = Member(name: "Quemby Witt", phone: "1-892-225-1794", address: "986-6729 Et Ave", email: "tristique.aliquet.Phasellus@enim.edu")
        let member9 = Member(name: "Martin Fitzgerald", phone: "1-896-870-3537", address: "Ap #340-2796 Eu, Av.", email: "cubilia.Curae@mollisnoncursus.edu")
        let member10 = Member(name: "Charlotte Hawkins", phone: "1-497-451-2990", address: "P.O. Box 652, 5298 Aptent St.", email: "sit@elit.com")
        let member11 = Member(name: "Quinn Owens", phone: "1-230-698-4439", address: "7647 Ac, Rd.", email: "eget.letius@facilisisSuspendisse.edu")
        let member12 = Member(name: "Avye Doyle", phone: "1-669-606-7819", address: "Ap #652-2435 Egestas. Ave", email: "eget.laoreet.posuere@Fuscediamnunc.co.uk")
        let member13 = Member(name: "Ross Perez", phone: "1-409-166-9108", address: "7788 Ut Avenue", email: "eu@Loremipsum.net")
        let member14 = Member(name: "Dahlia Dudley", phone: "1-973-474-8374", address: "853-4238 Sed Street", email: "enim@auctorMaurisvel.edu")
        let member15 = Member(name: "Hope Jackson", phone: "1-766-127-9216", address: "P.O. Box 172, 8297 Amet Rd.", email: "consequat@lobortis.co.uk")
        let member16 = Member(name: "Baxter Wilkins", phone: "1-771-660-2775", address: "Ap #645-3757 Enim. Avenue", email: "lacus.Mauris@acrisus.ca")
        let member17 = Member(name: "Anne Hoover", phone: "1-877-174-4057", address: "9227 Sed Av.", email: "pellentesque@enimdiamvel.com")
        let member18 = Member(name: "Gillian Castro", phone: "1-854-176-9674", address: "Ap #107-7858 Non, Avenue", email: "nec.urna.et@lectusjustoeu.net")
        let member19 = Member(name: "Hashim Stone", phone: "1-225-518-4719", address: "468-1798 Vestibulum St.", email: "ultricies.ornare@nulla.org")
        let member20 = Member(name: "Virginia Miranda", phone: "1-410-558-3479", address: "Ap #748-9767 Pede St.", email: "a.ultricies.adipiscing@nisl.edu")
        let member21 = Member(name: "Myra Castillo", phone: "1-590-181-5609", address: "Ap #661-558 Semper Av.", email: "per.conubia.nostra@aliquamenim.net")
        let member22 = Member(name: "Sawyer Ramirez", phone: "1-297-878-7386", address: "7674 Lorem, Avenue", email: "Quisque@egestashendrerit.co.uk")
        let member23 = Member(name: "Thane Townsend", phone: "1-222-616-2132", address: "1822 Commodo Av.", email: "a.dui@nequeNullamnisl.org")
        let member24 = Member(name: "Eleanor Erickson", phone: "1-417-559-1259", address: "P.O. Box 405, 1635 Quisque Av.", email: "Fusce.aliquet.magna@Vestibulumaccumsanneque.net")
        let member25 = Member(name: "Hanae Franklin", phone: "1-684-828-7671", address: "Ap #683-7607 Fringilla. St.", email: "congue.elit@Maurisquisturpis.edu")
        let member26 = Member(name: "Alana Stewart", phone: "1-632-659-1613", address: "Ap #836-9031 In, Av.", email: "rhoncus.Proin.nisl@ipsum.com")
        let member27 = Member(name: "Otto Blackwell", phone: "1-959-719-9090", address: "Ap #782-2349 Mi St.", email: "a.nunc.In@Lorem.org")
        let member28 = Member(name: "Lucius Levy", phone: "1-748-139-1653", address: "950-6328 Parturient St.", email: "enim.nisl@semsempererat.org")
        let member29 = Member(name: "Fitzgerald Wilkerson", phone: "1-653-215-2763", address: "562-6852 Cursus Rd.", email: "consectetuer.ipsum@tortor.org")
        let member30 = Member(name: "Elvis Contreras", phone: "1-513-332-7616", address: "9889 Luctus Avenue", email: "ornare.In@cursusetmagna.ca")
        let member31 = Member(name: "Kiayada Humphrey", phone: "1-766-820-3739", address: "P.O. Box 836, 2352 Blandit Rd.", email: "In@luctusCurabituregestas.edu")
        let member32 = Member(name: "Thane Fitzpatrick", phone: "1-393-346-3394", address: "376-1709 Nisi Ave", email: "purus@dictumcursus.com")
        let member33 = Member(name: "Serena Campos", phone: "1-605-249-0533", address: "Ap #123-6866 Cursus Rd.", email: "enim.diam@sitamet.org")
        let member34 = Member(name: "Elmo Cash", phone: "1-857-348-1703", address: "165-6792 Ligula. Av.", email: "et.ultrices@ornareFuscemollis.ca")
        let member35 = Member(name: "Leigh Bowen", phone: "1-381-213-0452", address: "Ap #783-9119 Natoque Rd.", email: "ante@leoMorbineque.edu")
        let member36 = Member(name: "Dora Snyder", phone: "1-340-637-1296", address: "3693 Congue Rd.", email: "amet@molestie.org")
        let member37 = Member(name: "Madaline Blanchard", phone: "1-968-541-8276", address:" 5336 Magna St.", email: "Quisque.nonummy.ipsum@ut.org")
        let member38 = Member(name: "Shay Norton", phone: "1-873-698-8330", address: "785-8550 Dis Ave", email: "mollis@hymenaeosMauris.ca")
        let member39 = Member(name: "Axel Kaufman", phone: "1-682-546-4690", address: "Ap #281-7126 Primis Rd.", email: "magnis.dis.parturient@amagna.ca")
        let member40 = Member(name: "Cameron Wilder", phone: "1-400-568-1774", address: "P.O. Box 345, 419 Eget, Road", email: "dolor@dictum.org")
        let member41 = Member(name: "Lunea Kent", phone: "1-679-536-1747", address: "Ap #154-2659 Accumsan Ave", email: "ipsum.Donec.sollicitudin@ac.edu")
        let member42 = Member(name: "Pearl Nielsen", phone: "1-367-330-0369", address: "Ap #851-9871 Mauris Street", email: "nibh@senectusetnetus.edu")
        let member43 = Member(name: "Chaim Doyle", phone: "1-906-882-6747", address: "634-4724 Lobortis Rd.", email: "consectetuer.euismod@Donec.edu")
        let member44 = Member(name: "Benjamin Wilkerson", phone: "1-369-404-9241", address: "126-3599 Sapien. St.", email: "a.malesuada.id@aliquamenim.org")
        let member45 = Member(name: "Shellie Hanson", phone: "1-319-293-9953", address: "P.O. Box 272, 378 Tellus Ave", email: "lacus.Nulla@senectuset.co.uk")
        let member46 = Member(name: "Jermaine Coffey", phone: "1-839-654-3614", address: "172 Molestie St.", email: "augue@Proinsed.com")
        let member47 = Member(name: "Rogan Boyer", phone: "1-239-147-4145", address: "Ap #988-6752 Tristique Ave", email: "Nam@euismodest.edu")
        let member48 = Member(name: "Wang Howell", phone: "1-619-518-9393", address: "5597 Nulla Road", email: "sit.amet.consectetuer@lectus.ca")
        let member49 = Member(name: "Brady Hicks", phone: "1-661-542-1104", address: "Ap #789-6642 Luctus Road", email: "mauris.ipsum.porta@rutrum.edu")
        let member50 = Member(name: "Maite Hartman", phone: "1-290-466-2835", address: "P.O. Box 243, 795 Diam Avenue", email: "mi@aodio.com")
        let member51 = Member(name: "Brett Wright", phone: "1-489-704-7766", address: "4160 Ipsum Ave", email: "dictum.eu@diam.edu")
        let member52 = Member(name: "Cara Andrews", phone: "1-399-478-8858", address: "Ap #546-3984 Venenatis Ave", email: "aliquet.Proin.velit@libero.com")
        let member53 = Member(name: "Zephr Flynn", phone: "1-220-948-8326", address: "813 Rutrum Rd.", email: "cursus@nuncQuisque.com")
        let member54 = Member(name: "Kellie Oneal", phone: "1-157-235-0886", address: "Ap #429-9815 Semper Av.", email: "sit@estNuncullamcorper.com")
        let member55 = Member(name: "Violet Vaughn", phone: "1-937-933-6874", address: "6872 Duis St.", email: "sollicitudin.adipiscing.ligula@Vestibulum.co.uk")
        let member56 = Member(name: "Cassandra Rollins", phone: "1-775-809-8241", address: "Ap #171-2718 Velit. Ave", email: "porta.elit.a@quamCurabitur.edu")
        let member57 = Member(name: "Hayden Alexander", phone: "1-176-601-5617", address: "P.O. Box 678, 1894 Quisque Ave", email: "Mauris.magna.Duis@enim.co.uk")
        let member58 = Member(name: "September Goodwin", phone: "1-267-137-8791", address: "P.O. Box 519, 8931 Eu, Av.", email: "turpis.egestas@purus.ca")
        let member59 = Member(name: "Clare Bates", phone: "1-904-635-2948", address: "Ap #591-199 Metus. Rd.", email: "molestie@ligula.net")
        let member60 = Member(name: "Christine Pollard", phone: "1-827-903-1336", address: "493-6783 Quisque Av.", email: "non.enim.Mauris@antebibendum.org")
        let member61 = Member(name: "Jada Greene", phone: "1-836-355-3384", address: "P.O. Box 953, 7599 Amet Avenue", email: "eget.laoreet@Fuscealiquet.co.uk")
        members.append(member1)
        members.append(member2)
        members.append(member3)
        members.append(member4)
        members.append(member5)
        members.append(member6)
        members.append(member7)
        members.append(member8)
        members.append(member9)
        members.append(member10)
        members.append(member11)
        members.append(member12)
        members.append(member13)
        members.append(member14)
        members.append(member15)
        members.append(member16)
        members.append(member17)
        members.append(member18)
        members.append(member19)
        members.append(member20)
        members.append(member21)
        members.append(member22)
        members.append(member23)
        members.append(member24)
        members.append(member25)
        members.append(member26)
        members.append(member27)
        members.append(member28)
        members.append(member29)
        members.append(member30)
        members.append(member31)
        members.append(member32)
        members.append(member33)
        members.append(member34)
        members.append(member35)
        members.append(member36)
        members.append(member37)
        members.append(member38)
        members.append(member39)
        members.append(member40)
        members.append(member41)
        members.append(member42)
        members.append(member43)
        members.append(member44)
        members.append(member45)
        members.append(member46)
        members.append(member47)
        members.append(member48)
        members.append(member49)
        members.append(member50)
        members.append(member51)
        members.append(member52)
        members.append(member53)
        members.append(member54)
        members.append(member55)
        members.append(member56)
        members.append(member57)
        members.append(member58)
        members.append(member59)
        members.append(member60)
        members.append(member61)
        
        members.sort {
            $0 < $1
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath)
        
        let member = members[indexPath.row]
        cell.textLabel?.text = member.name
        cell.detailTextLabel?.text = member.phone
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = members[indexPath.row]
        
        delegate?.membersTableViewController(self, didFinishSelecting: member)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editMember" {
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                
                let member = members[indexPath.row]
                
                let navController = segue.destination as! UINavigationController
                let addMemberVC = navController.topViewController as! AddMemberTableViewController
                addMemberVC.delegate = self
                addMemberVC.member = member
                
            }
            
        }
        
    }
    
}

extension MembersTableViewController: AddMemberTableViewControllerDelegate {
    
    func addMemberTableViewControllerDidCancel(_ controller: AddMemberTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addMemberTableViewController(_ controller: AddMemberTableViewController, didFinishAddingMember member: Member) {
        members.append(member)
        tableView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
    func addMemberTableViewController(_ controller: AddMemberTableViewController, didFinishEditing member: Member) {
        
        if let index = members.index(of: member) {
            let indexPath = IndexPath(row: index, section: 0)
            members[index] = member
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

func < (lhs: Member, rhs: Member) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
