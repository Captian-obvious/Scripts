#include <iostream>
#include <string>
#include <unordered_map>

std::unordered_map<std::string, std::string> parseArgs(int argc, char* argv[]) {
    std::unordered_map<std::string, std::string> args;
    for (int i = 1; i < argc; ++i){
        std::string key = argv[i];
        if (key.rfind("--", 0) == 0){
            std::string flag = key.substr(2);
            if (i + 1 < argc && std::string(argv[i + 1]).rfind("--", 0) != 0) {
                args[flag] = argv[i + 1]; // Flag with value
                i++;
            }else{
                args[flag] = "true"; // Boolean flag
            };
        };
    };
    return args;
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
        auto args = parseArgs(argc, argv);
        if (args.count("help")){
            printUsage();
            return 0;
        };
        if (args.count("user")){
            std::string user=args["user"];
            if (user=="true"){
                print_err("User cannot be 'true'. Please specify a valid username.");
                return 1;
            };
            if (user.empty()){
                print_err("User cannot be empty. Please specify a valid username.");
                return 1;
            };
            // Proceed with listing schedules for the specified user
            std::cout << "Listing schedules for user: " << user << std::endl;
            if (args.count("t")){
                std::string time = args["t"];
                std::cout << "Time specified: " << time << std::endl;
            }else{
                std::cout << "No specific time provided." << std::endl;
            };
            if (args.count("tformat")){
                std::string tformat = args["tformat"];
                std::cout << "Time format specified: " << tformat << std::endl;
            }else{
                std::cout << "No specific time format provided." << std::endl;
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