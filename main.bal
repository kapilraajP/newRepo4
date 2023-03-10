import ballerina/io;
import ballerinax/googleapis.sheets as sheets;

type OAuth2RefreshTokenGrantConfig record {
    string clientId;
    string clientSecret;
    string refreshToken;
    string refreshUrl = "https://www.googleapis.com/oauth2/v3/token";
};

string SheetId = "1teKpc-0Pe5tfgtK7Nql95iRUa8B3bO6hwfCMrQP6NwI";
string WorkspaceName = "Sheet1";
configurable OAuth2RefreshTokenGrantConfig GSheetAuthConfig = ?;
public function main() returns error? {
    sheets:Client spreadsheetClient = check new ({
        auth: {
            clientId: GSheetAuthConfig.clientId,
            clientSecret: GSheetAuthConfig.clientSecret,
            refreshToken: GSheetAuthConfig.refreshToken,
            refreshUrl: GSheetAuthConfig.refreshUrl
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
