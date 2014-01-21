require 'cfpropertylist'
require 'json'
require 'net/http'
require 'sqlite3'

namespace :db do
  desc 'Prime the location database'
  task :prime do
    db_name = 'LUPersistedObjectsInitial.sqlite'
    db_path = 'Source/Resources'
    local_db = File.join(db_path, db_name)
    db = SQLite3::Database.new(local_db)
    db.execute 'DELETE FROM ZLOCATION;'

    endpoint = '/v14/locations'

    while true
      puts "Fetching from: api.thelevelup.com#{endpoint}"
      data = Net::HTTP.start('api.thelevelup.com', :use_ssl => true).get(endpoint)

      if data.code == '204'
        break
      else
        json = JSON.parse(data.body)
        update_records_with_locations db, json.map { |j| j['location'] }
        endpoint = data['link'].scan(/\.com(\/v14.*)>/).join
      end
    end

    maxID = db.last_insert_row_id
    db.execute 'UPDATE Z_PRIMARYKEY SET Z_MAX=? WHERE Z_ENT=1', maxID

    update_metadata_with_endpoint db, endpoint
  end
end

def normalized_location!(location)
  location['shown'] = location['shown'] ? 1 : 0

  if location['categories']
    location['categories'] = location['categories'].join('|')
  end

  if location['updated_at']
    osx_epoch = DateTime.new(2001, 1, 1).to_time
    created = DateTime.iso8601(location['updated_at']).to_time
    location['updated_at'] = (created - osx_epoch).to_i
  end

  location
end

def update_metadata_with_endpoint(db, endpoint)
  plist_data = db.execute('SELECT Z_PLIST FROM Z_METADATA;')
  plist = CFPropertyList::List.new(:data => plist_data[0][0])
  data = CFPropertyList.native_types(plist.value)
  data['LULocationCacheUpdaterNextPageURLKey'] = "https://api.thelevelup.com#{endpoint}"
  plist.value = CFPropertyList.guess(data)
  db.execute 'UPDATE Z_METADATA SET Z_PLIST = :plist', 'plist' => plist.to_str
end

def update_records_with_locations(db, locations)
  locations.each do |location|
    sql = <<-SQL
      INSERT INTO ZLOCATION
        (Z_ENT, Z_OPT, ZLOCATIONID, ZMERCHANTID, ZSHOWN, ZLATITUDE, ZLONGITUDE, ZUPDATEDATDATE, ZCATEGORYIDS, ZMERCHANTNAME, ZNAME)
      VALUES (
        1, 1, :id, :merchant_id, :shown, :latitude, :longitude, :updated_at, :categories, :merchant_name, :name
      );
    SQL

    db.execute sql, normalized_location!(location)
  end
end
