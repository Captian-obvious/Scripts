#include <iostream>
#include <string>
#include <unordered_map>

std::unordered_map<std::string, std::string> parseArgs(int argc, char* argv[]) {
    std::unordered_map<std::string, std::string> args;
    for (int i = 1; i < argc; ++i) {
        std::string key = argv[i];
        if (key.rfind("--", 0) == 0 && i + 1 < argc) {
            std::string value = argv[i + 1];
            if (value.rfind("--", 0) != 0) { // Ensure value isn't another flag
                args[key.substr(2)] = value;
                i++;
            } else {
                args[key.substr(2)] = "";
            };
        };
    };
    return args;
};

void printUsage() {
    std::cout << "Usage: ls-schedules --user <username>" << std::endl;
    std::cout << "List all stored schedules for a particular user." << std::endl;
    std::cout << "Options:" << std::endl;
    std::cout << "  --user <username>   Specify the user to list schedules for." << std::endl;
    std::cout << "  --help              Show this help message." << std::endl;
};

void print_err(const std::string& msg) {
    std::cout << "\033[1;31m" << msg << "\033[0m" << std::endl;
};

int main(int argc,char* argv[]){
    if (argc>1){
        auto args = parseArgs(argc, argv);
        if (args.count("help")) {
            printUsage();
            return 0;
        };
        if (args.count("user")){
            std::string user=args["user"];
            std::cout<<user<<std::endl;
        }else{
            print_err("User not specified. Use --user <username> to specify a user.");
            return 1;
        };
    }else{
        printUsage();
    };
    return 0;
};