import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/injection.dart';
import '../../domain/dto/user_dto.dart';
import '../../style/style.dart';

import '../bloc/cud_user/cud_user_bloc.dart';
import '../bloc/cud_user/cud_user_state.dart';
import '../bloc/user/user_bloc.dart';
import '../widget/common_widget.dart';

class InsertPage extends HookWidget {
  const InsertPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);

    final namaController = useTextEditingController();
    final adderssController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final cityController = useTextEditingController();

    return KeyboardDismissOnTap(
      child: BlocListener<CudUserBloc, CudUserState>(
        bloc: cudSl,
        listener: (_, state) {
          state.maybeWhen(
            orElse: () {},
            success: () => _onSuccess(context),
          );
        },
        child: BlocBuilder<CudUserBloc, CudUserState>(
          bloc: cudSl,
          builder: (context, state) => state.maybeWhen(
              loading: () => Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                    ),
                    body: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              failure: (failure) => ErrorWidget(failure),
              orElse: () => Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'Post User',
                        style: Themes.font(14),
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: ListView(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: namaController,
                              decoration: Themes.formStyle('Insert Nama'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }

                                return null;
                              },
                            ),
                            smallSpace(),
                            TextFormField(
                              keyboardType: TextInputType.streetAddress,
                              controller: adderssController,
                              decoration: Themes.formStyle('Insert Address'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Alamat tidak boleh kosong';
                                }

                                return null;
                              },
                            ),
                            smallSpace(),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: Themes.formStyle('Insert Email'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }

                                return null;
                              },
                            ),
                            smallSpace(),
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              decoration: Themes.formStyle('Insert Phone'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'No. HP tidak boleh kosong';
                                }

                                return null;
                              },
                            ),
                            smallSpace(),
                            TextFormField(
                              controller: cityController,
                              keyboardType: TextInputType.streetAddress,
                              decoration: Themes.formStyle('Insert Kota'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kota tidak boleh kosong';
                                }

                                return null;
                              },
                            ),
                            mediumSpace(),
                            TextButton(
                                onPressed: () {
                                  if (formKey.currentState != null) {
                                    if (formKey.currentState!.validate()) {
                                      final userDTO = UserDTO(
                                          name: namaController.text,
                                          address: adderssController.text,
                                          email: emailController.text,
                                          phoneNumber: phoneController.text,
                                          city: cityController.text);

                                      cudSl.add(CreateUser(userDTO: userDTO));
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.amber),
                                  child: Center(
                                    child: Text(
                                      'Insert',
                                      style: Themes.font(12),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  _onSuccess(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Sukses Input",
      fontSize: 12.0,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      toastLength: Toast.LENGTH_SHORT,
    ).then((_) {
      userSl.add(GetUser());
      Navigator.pop(context);
    });
  }
}
