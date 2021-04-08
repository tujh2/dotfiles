use std::thread::sleep;
use std::time::Duration;
use network_manager::{NetworkManager, DeviceState};
use serde::{Deserialize, Serialize};
use chrono::Local;
use battery::units::ratio::percent;
use battery::units::time::hour;

#[derive(Serialize, Deserialize, PartialEq, PartialOrd, Clone)]
struct BarEvent {
    #[serde(skip_serializing_if = "Option::is_none")]
    full_text: Option<String>,
    color: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    short_text: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    background: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    border: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    border_top: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    border_right: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    border_bottom: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    border_left: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    min_width: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    align: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    urgent: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    name: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    instance: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    separator: Option<bool>,
    #[serde(skip_serializing_if = "Option::is_none")]
    separator_block_width: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    markup: Option<String>,
}

impl Default for BarEvent {
    fn default() -> BarEvent {
        BarEvent {
            full_text: None,
            color: String::from("#FFFFFF"),
            short_text: None,
            background: None,
            border: None,
            border_top: None,
            border_right: None,
            border_bottom: None,
            border_left: None,
            min_width: None,
            align: None,
            urgent: None,
            name: None,
            instance: None,
            separator: None,
            separator_block_width: None,
            markup: None
        }
    }
}

fn format_battery(battery: &battery::Battery) -> String {
    let level = battery.state_of_charge().get::<percent>() as u8;
    match battery.state() {
        battery::State::Discharging => {
            let hours = if let Some(value) = battery.time_to_empty() { value.get::<hour>()} else { 0.0 };
            if level <= 20 {
                format!("<span font='Font Awesome 5 Free'></span>  <span font='Arimo-Regular' foreground=\"#FF0000\">{} %</span> ~{:.1}h", level, hours)
            } else if level <= 40 {
                format!("<span font='Font Awesome 5 Free'></span>  <span font='Arimo-Regular' foreground=\"#FFAE00\">{} %</span> ~{:.1}h", level, hours)
            } else if level <= 60 {
                format!("<span font='Font Awesome 5 Free'></span>  <span font='Arimo-Regular' foreground=\"#FFF600\">{} %</span> ~{:.1}h", level, hours)
            } else if level <= 85 {
                format!("<span font='Font Awesome 5 Free'></span>  <span font='Arimo-Regular' foreground=\"#A8FF00\">{} %</span> ~{:.1}h", level, hours)
            } else {
                format!("<span font='Font Awesome 5 Free'></span>  <span font='Arimo-Regular' foreground=\"#00FF00\">{} %</span> ~{:.1}h", level, hours)
            }
        }
        battery::State::Charging => {
            let hours = if let Some(value) = battery.time_to_full() { value.get::<hour>()} else { 0.0 };
            format!("<span font='Font Awesome 5 Free'></span> <span font='Arimo-Regular' foreground=\"#00FF00\">{} %</span> ~{:.1}h", level, hours)
        }
        battery::State::Full => {
            "<span font='Font Awesome 5 Free'></span> <span font='Arimo-Regular' foreground=\"#00FF00\">FULL</span>".to_string()
        }
        _ => "<span font='Font Awesome 5 Free'></span> <span font='Arimo-Regular' foreground=\"#FFAE00\">UNKNOWN</span>".to_string()
    }
}

fn main() {
    println!("{{ \"version\": 1 }}");
    println!("[");
    println!("[],");
    let network_manager = NetworkManager::new();
    
    let battery_manager = match battery::Manager::new() {
        Ok(man) => man,
        Err(_e) => { return; }
    };
    let mut batteries = match battery_manager.batteries() {
        Ok(bats) => bats,
        Err(_r) => { return; }
    };
    let mut bt = match batteries.next() {
        Some(Ok(bat)) => bat,
        Some(Err(_e)) => { return; },
        None => { return; }
    };
    let network_device = network_manager.get_device_by_interface("wlan0").unwrap();
    let mut network_event = BarEvent { ..Default::default()  };
    let mut battery_event = BarEvent { ..Default::default()  };
    let mut clock_event = BarEvent { ..Default::default()  };
    
    loop {
        if battery_manager.refresh(&mut bt).is_err() {}

        let net_state = match network_device.get_state() {
            Ok(DeviceState::Activated) => "Activated".to_string(),
            _ => "".to_string()
        };
        let new_network_event = BarEvent {
            full_text: Some(format!("{}", net_state)),
            ..Default::default()
        };
        let new_battery_event = BarEvent {
            full_text: Some(format_battery(&bt)),
            markup: Some("pango".to_string()),
            ..Default::default()
        };
        let new_clock_event = BarEvent { 
            full_text: Some(Local::now().format("%R %v").to_string()),
            ..Default::default()
        };
        
        if new_clock_event != clock_event || new_network_event != network_event || new_battery_event != battery_event {
            clock_event = new_clock_event;
            battery_event = new_battery_event;
            network_event = new_network_event;
            let res = serde_json::to_string(&[network_event.clone(), battery_event.clone(),  clock_event.clone()]).unwrap();
            println!("{},", res);
        }

        sleep(Duration::from_millis(1000));
    }
}
