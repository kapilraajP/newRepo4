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
    sheets:Row existingColumnNames = check spreadsheetClient->getRow(SheetId, WorkspaceName, 1);
    if existingColumnNames.values.length() == 0 {
        final string[] & readonly columnNames = [
            "Column1",
            "Column2"
        ];
        check spreadsheetClient->appendRowToSheet(SheetId, WorkspaceName, columnNames);
    }

    (int|string|decimal)[] values = ["Test1", "Test2"];
    check spreadsheetClient->appendRowToSheet(SheetId, WorkspaceName, values);
    io:println("New row added to GSheet successfully!");
}
