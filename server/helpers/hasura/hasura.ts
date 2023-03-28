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

  async query(queryString: String) {
    try {
      const graphqlQuery = {
        query: queryString,
        variables: {},
      };

      let hasuraHeadersData = {
        "content-type": "application/json",
        "x-hasura-admin-secret":process.env.HASURA_GRAPHQL_ADMIN_SECRET,
      };
       
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
