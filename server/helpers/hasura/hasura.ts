import axios from "axios";
import ConstantHelper from "../constants/constants";

class HasuraHelper {
  private static instance: HasuraHelper;
  private constructor() {}
  public static getInstance(): HasuraHelper {
    if (!HasuraHelper.instance) {
      this.instance = new HasuraHelper();
    }
    return this.instance;
  }

  async query(queryString: String, headersData: any) {
    try {
      const graphqlQuery = {
        query: queryString,
        variables: {},
      };

      let hasuraHeadersData = {
        "content-type": "application/json",
        "x-hasura-admin-secret": headersData["x-hasura-admin-secret"] || "",
        "X-Hasura-Role": headersData["x-hasura-role"] || "",
        "X-Hasura-Is-Owner": headersData["x-hasura-is-owner"] || "",
      };
      console.log(headersData); 
      let response = await axios({
        url: ConstantHelper.hasuraBaseUrl,
        method: "post",
        headers: hasuraHeadersData,
        data: graphqlQuery,
      });

      if (response.data["errors"]) {
        throw new Error(
          response.data["errors"][0]["message"] || "something went wrong"
        );
      }

      return response.data["data"];
    } catch (e: any) {
      const errorText = e.message || "something went wrong";

      throw new Error(errorText);
    }
  }
}

export default HasuraHelper;
