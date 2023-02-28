abstract class HelpsDialogs {
  static const List<String> contentShareAddPage = [
    //Shared name
    "In this field, share name, you need to enter the name of the share. For example, if the field, shared name, is CID, the address in Windows will be \\\\computer\\CID, in Linux it will be smb://computer/CID",

    //Path
    "In this field, path, you need to enter the path of the folder to be shared. Example: /home/user/myfolder",

    //User
    "This field is optional, if you do not fill it in, by default the user to be inserted is all. But you can specify the permissions for your domain users, just type the user in the field.",

    //Group
    "This field is optional, if you do not fill it in, by default the group to be inserted is all. But you can specify permissions for groups in your domain, just enter group in the field. This field is recommended if you need permissions for more than three users. If this is the case, I advise you to create a group in the domain and enter these three users (or more).",
  ];

  static const List<String> contentLeaveDomainPage = [
    //Admin account
    "",

    //Password
    "",
  ];
}
