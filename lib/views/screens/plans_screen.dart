import 'package:dars/controllers/plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlansScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final planController = Provider.of<PlanController>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Plans')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    planController.addPlan(
                        titleController.text, descriptionController.text);
                  },
                  child: const Text('Add Plan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(
                        double.infinity, 50), // width: full, height: 50
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: planController.plans.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: planController.plans.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(planController.plans[index].title),
                        subtitle: Text(planController.plans[index].description),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            planController
                                .deletePlan(planController.plans[index].id);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
