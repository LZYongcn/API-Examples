import os, sys

def modfiy(path, isReset, appId):
    with open(path, 'r', encoding='utf-8') as file:
        contents = []
        for num, line in enumerate(file):
            line = line.strip()
            if "static let AppId" in line:
                if isReset:
                    line = "static let AppId: String = <#YOUR APPID#>"
                else:
                    line = f'static let AppId: String = "{appId}"'
            elif "Certificate" in line:
                if isReset:
                    line = "static let Certificate: String = <#YOUR Certificate#>"
                else:
                    line = 'static let Certificate: String = nil'
            contents.append(line)
        file.close()
        
        with open(path, 'w', encoding='utf-8') as fw:
            for content in contents:
                if "{" in content or "}" in content:
                    fw.write(content + "\n")
                else:
                    fw.write('\t'+content + "\n")
            fw.close()


if __name__ == '__main__':
    path = sys.argv[1:][0]
    isReset = eval(sys.argv[1:][1])
    appId = sys.argv[1:][2]
    modfiy(path.strip(), isReset, appId)