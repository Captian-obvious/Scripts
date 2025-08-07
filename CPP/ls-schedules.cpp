#include <iostream>
#include <string>
#include <unordered_map>

#ifdef __DEBUG_BUILD
std::unordered_map<std::string,std::string> config={
    {"help","bool"},
    {"user","value"},
    {"tformat","value"},
    {"t","value"},
    {"debug","bool"}
};
#else
std::unordered_map<std::string,std::string> config={
    {"help","bool"},
    {"user","value"},
    {"tformat","value"},
    {"t","value"}
};
#endif
std::unordered_map<std::string, std::string> parseArgs(int argc,char* argv[]) {
    std::unordered_map<std::string,std::string> args;
    for (int i=1;i<argc;i++){
        std::string key=argv[i];
        if (key.rfind("--", 0)==0){
            std::string flag=key.substr(2);
            if (config.count(flag)==0){
                std::cerr<<"Unknown flag: --"<<flag<<std::endl;
                continue;
            };
            if (config[flag]=="bool"){
                args[flag]="true";
            }else if (config[flag]=="value"){
                if (i+1<argc && std::string(argv[i+1]).rfind("--",0)!=0){
                    args[flag]=argv[i+1];
                    i++;
                }else{
                    std::cerr<<"Expected value for --"<<flag<<std::endl;
                };
            };
        };
    };
    return args;
};
unordered_map<std::string,std::string> queryUserSchedules(const std::string& user, const std::string& time = "", const std::string& tformat = "") {
    std::unordered_map<std::string,std::string> schedules;
    // Placeholder implementation
    schedules["2024-10-01 09:00"]="schedule1";
    return schedules;
};
void printUsage() {
    std::cout << "Usage: ls-schedules --user <username>" << std::endl;
    std::cout << "List all stored schedules for a particular user." << std::endl;
    std::cout << "Options:" << std::endl;
    std::cout << "  --user <username>       Specify the user to list schedules for." << std::endl;
    std::cout << "  --t <time>              Specify the time to list schedules around. (Optional)" << std::endl;
    std::cout << "  --tformat <format>      Specify the time format. (Optional)" << std::endl;
    std::cout << "  --help                  Show this help message." << std::endl;
};
void print_err(const std::string& msg) {
    std::cout << "\033[1;31m" << msg << "\033[0m" << std::endl;
};
int main(int argc,char* argv[]){
    if (argc>1){
        auto args=parseArgs(argc,argv);
        if (args.count("help")){
            printUsage();
            return 0;
        };
        #ifdef __DEBUG_BUILD
        if (args.count("debug")){
            std::cout<<"Debug mode enabled."<<std::endl;
            std::cout<<"Parsed arguments:"<<std::endl;
            for (const auto& arg : args) {
                std::cout<<"  --"<<arg.first<<": "<<arg.second<<std::endl;
            };
            return 0;
        };
        #endif
        if (args.count("user")){
            std::string user=args["user"];
            if (user.empty()){
                print_err("User cannot be empty. Please specify a valid username.");
                return 1;
            };
            // Proceed with listing schedules for the specified user
            std::cout<<"Listing schedules for user: "<<user<<std::endl;
            if (args.count("t")){
                std::string time=args["t"];
                std::cout<<"Time specified: "<<time<<std::endl;
            }else{
                std::cout<<"No specific time provided."<<std::endl;
            };
            if (args.count("tformat")){
                std::string tformat=args["tformat"];
                std::cout<<"Time format specified: "<<tformat<<std::endl;
            }else{
                std::cout<<"No specific time format provided."<<std::endl;
            };
            auto schedules=queryUserSchedules(user, args.count("t") ? args["t"] : "", args.count("tformat") ? args["tformat"] : "");
            if (schedules.empty()){
                std::cout<<"No schedules found for user: "<<user<<std::endl;
                return 0;
            };
            std::cout<<"Schedules for user "<<user<<":"<<std::endl;
            for (const auto& schedule : schedules) {
                std::cout<<"  - "<<schedule.first<<": "<<schedule.second<<std::endl
            };
        }else{
            print_err("User not specified. Use --user <username> to specify a user.");
            return 1;
        };
    }else{
        printUsage();
    };
    return 0;
};