import ballerina/io;
import ballerinax/googleapis.sheets as sheets;

configurable string cid = ?;
configurable string csecret = ?;
configurable string rtoken = ?;
configurable string rurl = ?;

public function main() returns error? {
    sheets:Client spreadsheetClient = check new ({
        auth: {
            clientId: cid,
            clientSecret: csecret,
            refreshToken: rtoken,
            refreshUrl: rurl
        }
    });
    sheets:Row existingColumnNames = check spreadsheetClient->getRow("1teKpc-0Pe5tfgtK7Nql95iRUa8B3bO6hwfCMrQP6NwI", "Sheet1", 1);
    if existingColumnNames.values.length() == 0 {
        final string[] & readonly columnNames = [
            "Column1",
            "Column2"
        ];
        check spreadsheetClient->appendRowToSheet("1teKpc-0Pe5tfgtK7Nql95iRUa8B3bO6hwfCMrQP6NwI", "Sheet1", columnNames);
    }

    (int|string|decimal)[] values = ["Test1", "Test2"];
    check spreadsheetClient->appendRowToSheet("1teKpc-0Pe5tfgtK7Nql95iRUa8B3bO6hwfCMrQP6NwI", "Sheet1", values);
    io:println("New row added to GSheet successfully!");
}
