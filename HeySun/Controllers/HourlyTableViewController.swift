import UIKit

class HourlyTableViewController: UITableViewController {
  
  @IBOutlet var viewModel: ViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "HourlyTableViewCell", bundle: nil), forCellReuseIdentifier: "HourlyCell")
    tableView.rowHeight = 70
    
    viewModel.fetchHourlyWeather(long: 56.834103, lat: 60.602743, onSuccess: { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }) { (error) in
      print("error", error)
    }
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection()
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyCell", for: indexPath) as? HourlyTableViewCell else { return UITableViewCell() }
    cell.tempLabel.text = viewModel.tempForTempLabel(at: indexPath)
    cell.hourLabel.text = viewModel.timeForHourLabel(at: indexPath)
    cell.imageView?.image = UIImage(named: viewModel.descAndImage(at: indexPath)?.image ?? "")
    cell.descLabel.text = viewModel.descAndImage(at: indexPath)?.description
    cell.backgroundColor = viewModel.backgroundForCell(at: indexPath)
    cell.labels.forEach { $0.textColor = viewModel.colorForLabels(at: indexPath)}
    return cell
  }
}
