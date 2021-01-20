//
//  Item+CoreDataClass.swift
//  Airlock
//
//  Created by Laurent B on 20/01/2021.
//
//

import Foundation
import CoreData


extension CodingUserInfoKey {
	static let context = CodingUserInfoKey(rawValue: "context")
}

enum DecoderConfigurationError: Error {
	case missingManagedObjectContext
	case missingEntity
}

public class Item: NSManagedObject, Codable {

	enum CodingKeys: CodingKey {
		case creationDate, myText, timeMeditated
	}

	required convenience public init(from decoder: Decoder) throws {
		guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else {  throw DecoderConfigurationError.missingManagedObjectContext }

		guard let entity = NSEntityDescription.entity(forEntityName: "Item", in: context) else {  throw DecoderConfigurationError.missingEntity }

		self.init(entity: entity, insertInto: context)

		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.creationDate = try container.decode(Date.self, forKey: .creationDate)
		self.myText = try container.decode(String.self, forKey: .myText)
		self.timeMeditated = try container.decode(Int16.self, forKey: .timeMeditated)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(creationDate, forKey: .creationDate)
		try container.encode(myText, forKey: .myText)
		try container.encode(timeMeditated, forKey: .timeMeditated)
	}
}
