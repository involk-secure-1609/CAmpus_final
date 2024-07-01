import 'dart:io';
import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/create_project_model.dart';
import 'package:campuscollaborate/services/contributor_search_screen_service.dart';
import 'package:campuscollaborate/services/docs_and_images.dart';
import 'package:campuscollaborate/services/drop_down_services.dart';
import 'package:campuscollaborate/services/project_services.dart';
import 'package:campuscollaborate/services/toggle_button_services.dart';
import 'package:campuscollaborate/widgets/commonWidgets/app_bar.dart';
import 'package:campuscollaborate/widgets/commonWidgets/common_elevated_button.dart';
import 'package:campuscollaborate/widgets/createProjectScreen/contributor_with_cross.dart';
import 'package:campuscollaborate/widgets/createProjectScreen/drop_down_button.dart';
import 'package:campuscollaborate/widgets/createProjectScreen/elevated_button.dart';
import 'package:campuscollaborate/widgets/createProjectScreen/form_text_field_container.dart';
import 'package:campuscollaborate/widgets/createProjectScreen/multi_dropdown.dart';
import 'package:campuscollaborate/widgets/createProjectScreen/toggle_buttons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import '../widgets/createProjectScreen/docs_images.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final MultiSelectController multiSelectController = MultiSelectController();
  final TextEditingController projectTitleController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ProjectServices projectServices=ProjectServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar('New Project'),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormTextFieldContainer(
                  hintText: 'Project Name',
                  title: 'Project Title',
                  textEditingController: projectTitleController,
                ),
                const Text(
                  'Skills',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5,),
                MultipleSelectionDropDown(multiSelectDropDown: multiSelectController),
                const SizedBox(height: 10,),
                FormTextFieldContainer(
                  hintText: 'Few words describing your project.',
                  title: 'Description',
                  textEditingController: descriptionController,
                  maxLines: 8,
                ),
                CustomDropDownButton(textEditingController: durationController),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Project Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<ProjectStatusToggleButtonService>(
                    builder: (context, service, child) => CustomToggleButton(
                        onChange: (index) {
                          service.selectButton(index!);
                        },
                        isSelected: service.selectedList,
                        firstToggleText: 'Active',
                        secondToggleText: 'Inactive')),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Project Type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<ProjectTypeToggleButtonService>(
                    builder: (context, service, child) => CustomToggleButton(
                        onChange: (index) {
                          service.selectButton(index!);
                        },
                        isSelected: service.selectedList,
                        firstToggleText: 'Individual',
                        secondToggleText: 'Group')),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
               Consumer<ProjectTypeToggleButtonService>(builder: (context, service, child){
                 if(service.selectedList[0]){
                   return const SizedBox(height: 0,);
                 }
                 else{
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text(
                         'Contributors',
                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                       ),
                       const ContributorsWithCrossListView(),
                       AddElevatedButton(
                         buttonText: 'Add Contributor',
                         onTap: () {
                           context.read<ContributorSearchScreenService>().clearAllProviders();
                           navigationService.pushScreen(Routes.contributorSearchScreen);
                         },
                         prefixImage: Image.asset('assets/button_plus.png'),
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                     ],
                   );
                 }
               }),
                const Text(
                  'Uploads',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<DocsStateService>(builder: (context, service, child) {
                  if (service.docs.isEmpty) {
                    return const SizedBox(
                      height: 0,
                    );
                  }
                  return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: service.docs.map((docs) {
                        return DocsImagesWithCross(
                          docsName: path.basename(docs.path),
                          onCrossTap: ()async {
                            await service.removeDocs(docs);
                          },
                        );
                      }).toList());
                }),
                AddElevatedButton(
                  buttonText: 'Upload File',
                  onTap: ()async{
                    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.custom, allowedExtensions: ['pdf', 'docx']);
                    if(result!=null){
                      List<File> files = result.paths.map((path) => File(path!)).toList();
                      context.read<DocsStateService>().addDocs(files);
                    }
                  },
                  prefixImage: Image.asset('assets/upload.png'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Thumbnail',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<ProjectImageStateService>(
                    builder: (context, service, child) {
                  if (service.images==null) {
                    return const SizedBox(
                      height: 0,
                    );
                  }
                  return DocsImagesWithCross(
                    docsName: path.basename(service.images!.path),
                    onCrossTap: ()async{
                      await service.removeDocs(service.images!);
                    },
                  );
                }),
                AddElevatedButton(
                  buttonText: 'Upload New',
                  onTap: () async{
                    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
                    if(result!=null){
                      File files = File(result.files.single.path!);
                      context.read<ProjectImageStateService>().addImage(files);
                    }
                  },
                  prefixImage: Image.asset('assets/upload.png'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(child: CommonElevatedButton(onTap: ()async{
                      if(formKey.currentState!.validate()){
                        CreateProjectModel model=CreateProjectModel(
                            projectName: projectTitleController.text,
                            description: descriptionController.text,
                            skills: getSelectedSkills(multiSelectController.selectedOptions),
                            urls: [],
                            duration: durationController.text.isEmpty?'New Project':'${durationController.text} ${context.read<DropDownServices>().selectedValue}',
                            isActive: context.read<ProjectStatusToggleButtonService>().selectedList[0],
                            id: '',
                            admin: context.read<ContributorSearchScreenService>().selectedAdminsList,
                            starBy: null,
                            owner: '',
                            thumbnail: null
                        );
                        String? thumbNailPath = context.read<ProjectImageStateService>().images==null?null:context.read<ProjectImageStateService>().images!.path;
                        await projectServices.createProject(model, context,thumbNailPath, context.read<DocsStateService>().docs);
                      }
                }, text: 'Create New Project'))
              ],
            ),
          ),
        ),
      ),
    ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    projectTitleController.dispose();
    descriptionController.dispose();
    domainController.dispose();
    durationController.dispose();
    multiSelectController.dispose();
  }
}

List<String> getSelectedSkills(List<ValueItem> list){
  final List<String> listToBeReturned=[];
  for(int i=0; i<list.length;i++){
    listToBeReturned.add(list[i].value.toString());
  }
  return listToBeReturned;
}
